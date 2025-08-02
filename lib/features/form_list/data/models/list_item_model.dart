import 'package:dynamic_forms/features/form_list/domain/entities/list_item.dart';

class ListItemModel extends ListItem {
  ListItemModel({required super.name, required super.value});

  factory ListItemModel.fromJson(Map<String, dynamic> json) {
    return ListItemModel(name: json['name'], value: json['value']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'value': value};
  }
}
