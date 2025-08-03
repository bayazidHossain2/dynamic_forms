import 'package:dynamic_forms/core/theme/app_pallete.dart';
import 'package:dynamic_forms/features/form_list/domain/entities/field_properties.dart';
import 'package:flutter/material.dart';

class CustomTextFormFieldWithLabelWidget extends StatelessWidget {
  final FieldProperties properties;
  final TextEditingController controller;

  const CustomTextFormFieldWithLabelWidget({
    super.key,
    required this.properties,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            properties.label.toString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 4),
          TextFormField(
            controller: controller,
            keyboardType: properties.type == 'text'
                ? TextInputType.text
                : TextInputType.number,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppPallete.grey),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ), // Default border color
              ),

              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              hintText: properties.hintText,
              hintStyle: TextStyle(color: AppPallete.grey),
              // focusColor: ,
            ),
            validator: (value) {
              // if (isOptional) {
              //   return null;
              // }
              if (value!.isEmpty) {
                value = properties.defaultValue;
              }
              if (value.length > (properties.maxLength ?? 0)) {
                return '${properties.label} must be under ${properties.maxLength} character.';
              }
              if (value.length < (properties.minLength ?? 0)) {
                return '${properties.label} must be at least ${properties.minLength} character.';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
