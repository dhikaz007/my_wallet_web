part of 'storage.dart';

class StorageToken {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> setAccessToken({required String token}) async {
    print("Saving access token: $token");
    await secureStorage.write(key: "access_token", value: token);
  }

  Future<void> setRefreshToken({required String token}) async {
    print("Saving refresh token: $token");
    await secureStorage.write(key: "refresh_token", value: token);
  }

  Future<void> setTokenExpiry({required DateTime? token}) async {
    print("Saving token expiry: $token");
    await secureStorage.write(
        key: "token_expiry", value: token?.toIso8601String());
  }

  Future<String?> getAccessToken() async {
    final token = await secureStorage.read(key: "access_token");
    print("Getting access token: $token");
    return token;
  }

  Future<String?> getRefreshToken() async {
    final token = await secureStorage.read(key: "refresh_token");
    print("Getting refresh token: $token");
    return token;
  }

  Future<DateTime?> getTokenExpiry() async {
    final token = await secureStorage.read(key: "token_expiry");
    print("Getting token expiry: $token");
    if (token == null) return null;
    return DateTime.tryParse(token);
  }

  Future<void> deleteAll() async {
    await secureStorage.deleteAll();
  }
}
