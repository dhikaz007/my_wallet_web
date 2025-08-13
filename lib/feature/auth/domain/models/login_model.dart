part of 'models.dart';

class LoginModel {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;
  final int? expiresAt;
  final String? refreshToken;
  final UserModel? user;

  const LoginModel({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.expiresAt,
    this.refreshToken,
    this.user,
  });

  factory LoginModel.fromJSON(Map<String, dynamic> json) {
    return LoginModel(
      accessToken:
          json['access_token'] != null ? json['access_token'] as String : null,
      tokenType:
          json['token_type'] != null ? json['token_type'] as String : null,
      expiresIn: json['expires_in'] != null ? json['expires_in'] as int : null,
      expiresAt: json['expires_at'] != null ? json['expires_at'] as int : null,
      refreshToken: json['refresh_token'] != null
          ? json['refresh_token'] as String
          : null,
      user: json['user'] != null
          ? UserModel.fromJSON(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  String toString() {
    return 'LoginModel(accessToken: $accessToken, tokenType: $tokenType, expiresIn: $expiresIn, expiresAt: $expiresAt, refreshToken: $refreshToken, user: $user)';
  }
}
