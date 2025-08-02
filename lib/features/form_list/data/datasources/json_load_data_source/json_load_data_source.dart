import 'package:dynamic_forms/core/services/json_loader/json_loader_service.dart';
import 'package:dynamic_forms/features/form_list/data/models/dynamic_form_model.dart';
import 'package:dynamic_forms/features/form_list/domain/entities/dynamic_form.dart';

abstract interface class JsonLoadDataSource {
  Future<List<DynamicForm>> getAllDynamicForm();
}

class JsonLoadDataSourceImpl implements JsonLoadDataSource {
  @override
  Future<List<DynamicForm>> getAllDynamicForm() async {
    List<DynamicForm> dynamicFormList = [];
    for (int i = 1; i <= 3; i++) {
      final jsonData = await JsonLoaderService.load(fileName: 'form_$i');
      final dynamicForm = DynamicFormModel.fromJson(jsonData);
      dynamicFormList.add(dynamicForm);
    }
    return dynamicFormList;
  }
}
