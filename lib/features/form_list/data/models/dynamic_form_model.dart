import 'package:dynamic_forms/features/form_list/data/models/section_model.dart';
import 'package:dynamic_forms/features/form_list/domain/entities/dynamic_form.dart';

class DynamicFormModel extends DynamicForm {
  DynamicFormModel({
    required super.formName,
    required super.id,
    required super.sections,
  });

  factory DynamicFormModel.fromJson(Map<String, dynamic> json) {
    return DynamicFormModel(
      formName: json['formName'],
      id: json['id'],
      sections: (json['sections'] as List)
          .map((e) => SectionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'formName': formName,
      'id': id,
      'sections': sections.map((e) => (e as SectionModel).toJson()).toList(),
    };
  }
}
