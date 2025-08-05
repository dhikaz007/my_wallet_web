part of 'extensions.dart';

extension StringExtension on String {
  String typeToString() {
    final name = toString().split('.').last;
    final withSpace = name.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)} ${match.group(2)}',
    );
    return withSpace.toUpperCase();
  }

  String capitalizeEachWord() {
    if (isEmpty) return this;

    // 1️⃣ Tambahkan spasi sebelum huruf besar (misal bahanMakanan → bahan Makanan)
    String withSpaces = replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)} ${match.group(2)}',
    );

    // 2️⃣ Pisahkan kata & kapitalisasi huruf pertamanya
    return withSpaces
        .split(RegExp(r'\s+')) // pisahkan berdasarkan spasi (1 atau lebih)
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '')
        .join(' ');
  }
}
