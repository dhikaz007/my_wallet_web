part of 'services.dart';

class ResponseAPI<T> {
  final int? code;
  final String? errorCode;
  final String? mgs;
  final T? data;

  const ResponseAPI({
    this.code,
    this.errorCode,
    this.mgs,
    this.data,
  });

  factory ResponseAPI.fromJSON(Map<String, dynamic> json) {
    return ResponseAPI(
      data: json['data'],
      code: json['code'] != null ? json['code'] as int : null,
      errorCode:
          json['error_code'] != null ? json['error_code'] as String : null,
      mgs: json['mgs'] != null ? json['mgs'] as String : null,
    );
  }

  @override
  String toString() =>
      'ResponseAPI(code: $code, errorCode: $errorCode, mgs: $mgs)';
}
