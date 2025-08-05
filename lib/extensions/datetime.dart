part of 'extensions.dart';

final globalDateNow = DateTime.now();

extension DateTimeExtension on DateTime {
  String getFullDate({int? format}) {
    switch (format) {
      case 1:
        return DateFormat('dd/M/y', 'id').format(this);
      case 2:
        return DateFormat('dd/MM/y', 'id').format(this);
      case 3:
        return DateFormat('dd MMM y', 'id').format(this);
      case 4:
        return DateFormat('dd MMMM y', 'id').format(this);
      default:
        return DateFormat('dd MMMM y', 'id').format(this);
    }
  }

  String getMonth({int? format}) {
    switch (format) {
      case 1:
        return DateFormat('M', 'id').format(this);
      case 2:
        return DateFormat('MM', 'id').format(this);
      case 3:
        return DateFormat('MMM', 'id').format(this);
      case 4:
        return DateFormat('MMMM', 'id').format(this);
      default:
        return DateFormat('MMMM', 'id').format(this);
    }
  }

  String getYear() {
    return DateFormat('y', 'id').format(this);
  }

  String getDate({int? format}) {
    switch (format) {
      case 1:
        return DateFormat('d', 'id').format(this);
      case 2:
        return DateFormat('dd', 'id').format(this);
      default:
        return DateFormat('dd', 'id').format(this);
    }
  }
}
