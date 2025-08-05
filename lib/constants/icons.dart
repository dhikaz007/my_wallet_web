part of 'constants.dart';

class IconsApp {
  static const String _base = 'assets/icons';
  static String _path(String fileName) {
    // 🔍 Kalau Web, jangan ada slash di depan (karena jadi absolute URL)
    // 🔍 Kalau Mobile (Android/iOS) boleh juga tanpa slash, tapi ini akan tetap aman
    return kIsWeb ? '$_base/$fileName' : '$_base/$fileName';
  }

  static final icBills = _path('ic_bills.svg');
  static final icPdf = _path('ic_pdf.svg');
}
