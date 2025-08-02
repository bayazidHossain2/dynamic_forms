import 'package:dynamic_forms/features/form_list/data/models/field_properties_model.dart';
import 'package:dynamic_forms/features/form_list/domain/entities/field.dart';

class FieldModel extends Field {
  FieldModel({
    required super.id,
    required super.key,
    required super.properties,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
      id: json['id'],
      key: json['key'],
      properties: FieldPropertiesModel.fromJson(json['properties']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'properties': (properties as FieldPropertiesModel).toJson(),
    };
  }
}
