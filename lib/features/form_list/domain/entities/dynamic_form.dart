import 'package:dynamic_forms/features/form_list/domain/entities/section.dart';

class DynamicForm {
  final String formName;
  final int id;
  final List<Section> sections;

  DynamicForm({
    required this.formName,
    required this.id,
    required this.sections,
  });
}
