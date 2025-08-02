import 'dart:convert';

import 'package:dynamic_forms/features/form_list/domain/entities/list_item.dart';

class FieldProperties {
   final String type;
   final String defaultValue;
   final String? hintText;
   final String? label;
   final int? minLength;
   final int? maxLength;
   final bool? multiSelect;
   final bool? multiImage;
   final List<ListItem>? listItems;

   FieldProperties({
       required this.type,
               required this.defaultValue,
               this.hintText,
               this.label,
               this.minLength,
               this.maxLength,
               this.multiSelect,
               this.multiImage,
               this.listItems,
   });
}