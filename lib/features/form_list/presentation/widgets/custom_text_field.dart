import 'package:dynamic_forms/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final int? maxLines;
  final String? imagePath;
  final bool isOptional;
  final Function(String)? onFormSubmitted;
  final Function()? onTap;
  final Function(String)? onChanged;
  final bool enabled;
  final TextStyle? textStyle;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.isOptional = false,
    this.maxLines,
    this.imagePath,
    this.onFormSubmitted,
    this.onTap,
    this.onChanged,
    this.enabled = true,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines ?? 1,
        onTap: onTap,
        onChanged: onChanged,
        enabled: enabled,
        style: textStyle,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
          focusColor: AppPallete.primary,
          // filled: true,
          // fillColor: AppPallete.white,
        ),
        validator: (value) {
          if (isOptional) {
            return null;
          }
          if (value!.isEmpty) {
            return '$labelText is required.';
          }
          return null;
        },
        onFieldSubmitted: onFormSubmitted,
      ),
    );
  }
}
