import 'package:dynamic_forms/core/utils/data_type/bool_controller.dart';
import 'package:flutter/material.dart';

class CustomCheckboxWidget extends StatefulWidget {
  final String text;
  final BoolController controller;
  final Function(bool value)? onChanged;

  const CustomCheckboxWidget({
    super.key,
    required this.text,
    required this.controller,
    this.onChanged,
  });

  @override
  State<CustomCheckboxWidget> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.controller.value = !widget.controller.value;
          if (widget.onChanged != null) {
            widget.onChanged!(widget.controller.value);
          }
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: widget.controller.value,
            onChanged: (bool? value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value ?? false);
              }
              setState(() {
                widget.controller.value = value ?? false;
              });
            },
            side: BorderSide(
              color: Colors.grey,
              width: 2,
            ),

            // fillColor: WidgetStatePropertyAll(),
          ),
          Text(widget.text),
        ],
      ),
    );
  }
}
