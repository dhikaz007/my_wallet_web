part of 'constants.dart';

class ImagesApp {
  static const String _base = 'assets/images';
  static String _path(String fileName) {
    // 🔍 Kalau Web, jangan ada slash di depan (karena jadi absolute URL)
    // 🔍 Kalau Mobile (Android/iOS) boleh juga tanpa slash, tapi ini akan tetap aman
    return kIsWeb ? '$_base/$fileName' : '$_base/$fileName';
  }

  static final imgLogo = _path('img_logo.png');
}