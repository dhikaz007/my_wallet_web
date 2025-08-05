part of 'models.dart';

enum TagihanType { bahanMakanan, jajan, motor }

String tagihanTypeToString(TagihanType type) => type.toString().split('.').last;

TagihanType stringToTagihanType(String type) {
  return TagihanType.values.firstWhere(
    (e) => e.toString().split('.').last == type,
    orElse: () => TagihanType.bahanMakanan,
  );
}

extension TagihanTypeExtension on TagihanType {
  String get formattedName {
    final name = toString().split('.').last;
    final withSpace = name.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)} ${match.group(2)}',
    );
    return withSpace.toUpperCase(); // jadi "BAHAN MAKANAN"
  }
}

extension TagihanModelExtension on ExpensesModel {
  String get typeFormatted => type;
}

class ExpensesModel {
  int? id;
  DateTime? createdDate;
  String type;
  String name;
  int value;

  ExpensesModel({
    this.id = 0,
    this.createdDate,
    this.type = '',
    this.name = '',
    this.value = 0,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'createdDate': createdDate?.toIso8601String(),
      'type': type,
      'name': name,
      'value': value,
    };
  }

  factory ExpensesModel.fromJson(Map<String, dynamic> json, {int? id}) {
    return ExpensesModel(
      id: id,
      createdDate: DateTime.parse(json['createdDate']),
      type: json['type'],
      name: json['name'],
      value: json['value'],
    );
  }

  @override
  String toString() {
    return 'TagihanModel(id: $id, createdDate: $createdDate, type: $type, name: $name, value: $value)';
  }
}
