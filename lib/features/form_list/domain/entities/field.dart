import 'package:dynamic_forms/features/form_list/domain/entities/field_properties.dart';

class Field {
  final int id;
  final String key;
  final FieldProperties properties;

  Field({required this.id, required this.key, required this.properties});
}
