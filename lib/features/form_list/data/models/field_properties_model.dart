import 'dart:convert';

import 'package:dynamic_forms/features/form_list/data/models/list_item_model.dart';
import 'package:dynamic_forms/features/form_list/domain/entities/field_properties.dart';

class FieldPropertiesModel extends FieldProperties {
  FieldPropertiesModel({
    required super.defaultValue,
    required super.hintText,
    required super.label,
    required super.listItems,
    required super.maxLength,
    required super.minLength,
    required super.multiImage,
    required super.multiSelect,
    required super.type,
  });

  factory FieldPropertiesModel.fromJson(Map<String, dynamic> json) {
    List<ListItemModel>? parsedItems;
    if (json['listItems'] != null && json['listItems'] is String) {
      parsedItems = (List<Map<String, dynamic>>.from(
        jsonDecode(json['listItems']),
      )).map((e) => ListItemModel.fromJson(e)).toList();
    }

    return FieldPropertiesModel(
      type: json['type'],
      defaultValue: json['defaultValue'],
      hintText: json['hintText'],
      label: json['label'],
      minLength: json['minLength'],
      maxLength: json['maxLength'],
      multiSelect: json['multiSelect'],
      multiImage: json['multiImage'],
      listItems: parsedItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'defaultValue': defaultValue,
      'hintText': hintText,
      'label': label,
      'minLength': minLength,
      'maxLength': maxLength,
      'multiSelect': multiSelect,
      'multiImage': multiImage,
      'listItems': listItems != null
          ? jsonEncode(
              listItems!.map((e) => (e as ListItemModel).toJson()).toList(),
            )
          : null,
    };
  }
}
