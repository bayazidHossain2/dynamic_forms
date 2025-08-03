import 'package:dynamic_forms/features/form_list/domain/entities/field_properties.dart';
import 'package:flutter/cupertino.dart';

class TextFieldWidget extends StatelessWidget {
  final FieldProperties properties;
  final TextEditingController controller;

  const TextFieldWidget({
    super.key,
    required this.properties,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              properties.label.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 4),
          Expanded(child: Text(controller.text.trim())),
        ],
      ),
    );
  }
}
