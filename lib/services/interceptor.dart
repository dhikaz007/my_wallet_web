part of 'services.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._storage);
  final StorageToken _storage;

  static const _retriedFlag = '__retried';

  bool _isAuthEndpoint(RequestOptions o) {
    final p = o.path; // bisa full URL
    return p.contains('/auth/v1/token') || p.contains('/auth/v1/signup');
  }

  Future<bool> _isAccessExpired() async {
    final exp = await _storage.getTokenExpiry();
    if (exp == null) return false; // <- JANGAN anggap expired saat null
    return DateTime.now().isAfter(exp.subtract(const Duration(seconds: 10)));
  }

  Future<void> _attachCommonHeaders(RequestOptions options) async {
    options.headers.addAll({
      'apikey': UrlApp.apiKey,
      'Prefer': 'return=representation',
      'Content-Type': 'application/json',
    });
  }

  Future<void> _attachAuthHeader(RequestOptions options) async {
    final token = await _storage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    } else {
      options.headers.remove('Authorization');
    }
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      await _attachCommonHeaders(options);

      final noAuth = options.extra['noAuth'] == true;
      if (noAuth || _isAuthEndpoint(options)) {
        // Jangan pasang Authorization & jangan cek expiry
        return handler.next(options);
      }

      // Untuk request yang butuh auth:
      await _attachAuthHeader(options);

      if (await _isAccessExpired()) {
        // Di sini *opsional*: trigger refresh token.
        // Kalau belum implement refresh, lebih baik biarkan request jalan,
        // nanti 401 ditangani di onError.
      }

      handler.next(options);
    } catch (e) {
      handler.reject(DioException(
        requestOptions: options,
        error: e,
        type: DioExceptionType.unknown,
      ));
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final req = err.requestOptions;
    final alreadyRetried = req.extra[_retriedFlag] == true;

    // Skip kalau ini request auth sendiri
    if (_isAuthEndpoint(req)) return handler.next(err);

    // Auto refresh saat 401/403 (opsional)
    final status = err.response?.statusCode ?? 0;
    if ((status == 401 || status == 403) && !alreadyRetried) {
      try {
        final rt = await _storage.getRefreshToken();
        if (rt == null || rt.isEmpty) {
          // Tidak bisa refresh → biarkan error ke UI (suruh login)
          return handler.next(err);
        }

        // Panggil refresh token Supabase
        final dioRefresh = Dio();
        await dioRefresh
            .post(
          '${UrlApp.authUrl}/token',
          queryParameters: {'grant_type': 'refresh_token'},
          data: {'refresh_token': rt},
          options: Options(extra: {'noAuth': true}), // penting
        )
            .then((resp) async {
          // Simpan access/refresh/expiry baru
          final data = resp.data as Map<String, dynamic>;
          await _storage.setAccessToken(token: data['access_token']);
          await _storage.setRefreshToken(token: data['refresh_token']);
          if (data['expires_in'] != null) {
            final expiry =
                DateTime.now().add(Duration(seconds: data['expires_in']));
            await _storage.setTokenExpiry(token: expiry);
          }
        });

        // Tandai sudah retried dan ulangi request asli dengan token baru
        req.extra[_retriedFlag] = true;
        final newDio = Dio()..interceptors.add(this);
        final cloned = await newDio.fetch(req);
        return handler.resolve(cloned);
      } catch (_) {
        // Refresh gagal → teruskan error (user harus login ulang)
        return handler.next(err);
      }
    }

    handler.next(err);
  }
}
