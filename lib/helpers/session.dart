part of 'helpers.dart';

class SessionApp {
  String? _cachedToken;

  Future<bool> hasValidSession() async {
    _cachedToken ??= await StorageToken().getAccessToken();
    return _cachedToken?.isNotEmpty == true;
  }

  bool get isLoggedInCached => _cachedToken?.isNotEmpty == true;

  void setToken(String? token) {
    _cachedToken = token;
  }

  void invalidate() {
    _cachedToken = null;
  }
}
