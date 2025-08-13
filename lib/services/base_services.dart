part of 'services.dart';

mixin BaseServices {
  final _options = BaseOptions(
    baseUrl: UrlApp.baseUrl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    headers: {'Content-Type': 'application/json'},
  );

  Future<Dio> dio() async {
    final dio = Dio(_options);
    final tokenStorage = StorageToken();

    dio.interceptors.clear();

    dio.interceptors.addAll([
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
      ),
      AuthInterceptor(tokenStorage),
    ]);

    return dio;
  }
}
