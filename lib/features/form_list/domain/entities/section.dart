import 'package:dynamic_forms/features/form_list/domain/entities/field.dart';

class Section {
  final String name;
  final String key;
  final List<Field> fields;

  Section({required this.name, required this.key, required this.fields});

}
