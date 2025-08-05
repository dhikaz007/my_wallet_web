part of 'models.dart';

class TypeModel {
  final int? id;
  final String label;

  TypeModel({this.id, required this.label});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'label': label,
    };
  }

  factory TypeModel.fromJson(Map<String, dynamic> json, {int? id}) {
    return TypeModel(
      id: id,
      label: json['label'] as String,
    );
  }

  @override
  String toString() => 'TypeModel(id: $id label: $label)';
}
