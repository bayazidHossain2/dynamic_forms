import 'package:dynamic_forms/features/form_list/data/models/field_model.dart';
import 'package:dynamic_forms/features/form_list/domain/entities/section.dart';

class SectionModel extends Section {
  SectionModel({
    required super.fields,
    required super.key,
    required super.name,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      name: json['name'],
      key: json['key'],
      fields: (json['fields'] as List)
          .map((field) => FieldModel.fromJson(field))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'key': key,
      'fields': fields.map((e) => (e as FieldModel).toJson()).toList(),
    };
  }
}
