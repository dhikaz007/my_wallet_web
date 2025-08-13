part of 'models.dart';

class UserModel {
  final String? id;
  final String? aud;
  final String? role;
  final String? email;
  final DateTime? emailConfirmedAt;
  final String? phone;
  final DateTime? confirmedAt;
  final DateTime? lastSignInAt;
  final AppMetaData? appMetadata;
  final UserMetaData? userMetadata;
  final List<Identity>? identities;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isAnonymous;

  const UserModel({
    this.id,
    this.aud,
    this.role,
    this.email,
    this.emailConfirmedAt,
    this.phone,
    this.confirmedAt,
    this.lastSignInAt,
    this.appMetadata,
    this.userMetadata,
    this.identities,
    this.createdAt,
    this.updatedAt,
    this.isAnonymous,
  });

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] != null ? json['id'] as String : null,
      aud: json['aud'] != null ? json['aud'] as String : null,
      role: json['role'] != null ? json['role'] as String : null,
      email: json['email'] != null ? json['email'] as String : null,
      emailConfirmedAt: json['email_confirmed_at'] != null
          ? DateTime.parse(json['email_confirmed_at'] as String)
          : null,
      phone: json['phone'] != null ? json['phone'] as String : null,
      confirmedAt: json['confirmed_at'] != null
          ? DateTime.parse(json['confirmed_at'] as String)
          : null,
      lastSignInAt: json['last_sign_in_at'] != null
          ? DateTime.parse(json['last_sign_in_at'] as String)
          : null,
      appMetadata: json['app_metadata'] != null
          ? AppMetaData.fromJSON(json['app_metadata'] as Map<String, dynamic>)
          : null,
      userMetadata: json['user_metadata'] != null
          ? UserMetaData.fromJSON(json['user_metadata'] as Map<String, dynamic>)
          : null,
      identities: json['identities'] != null
          ? List<Identity>.from(
              json["identities"]!.map((x) => Identity.fromJSON(x)))
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      isAnonymous:
          json['is_anonymous'] != null ? json['is_anonymous'] as bool : null,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, aud: $aud, role: $role, email: $email, emailConfirmedAt: $emailConfirmedAt, phone: $phone, confirmedAt: $confirmedAt, lastSignInAt: $lastSignInAt, appMetadata: $appMetadata, userMetadata: $userMetadata, identities: $identities, createdAt: $createdAt, updatedAt: $updatedAt, isAnonymous: $isAnonymous)';
  }
}

class AppMetaData {
  final String? provider;
  final List<String>? providers;

  const AppMetaData({this.provider, this.providers});

  factory AppMetaData.fromJSON(Map<String, dynamic> json) {
    return AppMetaData(
      provider: json['provider'] != null ? json['provider'] as String : null,
      providers: json['providers'] != null
          ? List<String>.from(json["providers"]!.map((x) => x))
          : null,
    );
  }

  @override
  String toString() =>
      'AppMetaData(provider: $provider, providers: $providers)';
}

class UserMetaData {
  final bool? emailVerified;
  final String? displayName;

  const UserMetaData({
    this.emailVerified,
    this.displayName,
  });

  factory UserMetaData.fromJSON(Map<String, dynamic> json) {
    return UserMetaData(
      emailVerified: json['email_verified'] != null
          ? json['email_verified'] as bool
          : null,
      displayName:
          json['display_name'] != null ? json['display_name'] as String : null,
    );
  }

  @override
  String toString() =>
      'UserMetaData(emailVerified: $emailVerified, displayName: $displayName)';
}

class Identity {
  final String? identityId;
  final String? id;
  final String? userId;
  final IdentityData? identityData;
  final String? provider;
  final DateTime? lastSignInAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? email;

  const Identity({
    this.identityId,
    this.id,
    this.userId,
    this.identityData,
    this.provider,
    this.lastSignInAt,
    this.createdAt,
    this.updatedAt,
    this.email,
  });

  factory Identity.fromJSON(Map<String, dynamic> json) {
    return Identity(
      identityId:
          json['identity_id'] != null ? json['identity_id'] as String : null,
      id: json['id'] != null ? json['id'] as String : null,
      userId: json['user_id'] != null ? json['user_id'] as String : null,
      identityData: json['identity_data'] != null
          ? IdentityData.fromJSON(json['identity_data'] as Map<String, dynamic>)
          : null,
      provider: json['provider'] != null ? json['provider'] as String : null,
      lastSignInAt: json['last_sign_in_at'] != null
          ? DateTime.parse(json['last_sign_in_at'] as String)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      email: json['email'] != null ? json['email'] as String : null,
    );
  }

  @override
  String toString() {
    return 'Identity(identityId: $identityId, id: $id, userId: $userId, identityData: $identityData, provider: $provider, lastSignInAt: $lastSignInAt, createdAt: $createdAt, updatedAt: $updatedAt, email: $email)';
  }
}

class IdentityData {
  final String? email;
  final bool? emailVerified;
  final bool? phoneVerified;
  final String? sub;

  const IdentityData({
    this.email,
    this.emailVerified,
    this.phoneVerified,
    this.sub,
  });

  factory IdentityData.fromJSON(Map<String, dynamic> json) {
    return IdentityData(
      email: json['email'] != null ? json['email'] as String : null,
      emailVerified: json['email_verified'] != null
          ? json['email_verified'] as bool
          : null,
      phoneVerified: json['phone_verified'] != null
          ? json['phone_verified'] as bool
          : null,
      sub: json['sub'] != null ? json['sub'] as String : null,
    );
  }

  @override
  String toString() {
    return 'IdentityData(email: $email, emailVerified: $emailVerified, phoneVerified: $phoneVerified, sub: $sub)';
  }
}
