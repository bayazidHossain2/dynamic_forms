import 'package:dynamic_forms/core/utils/data_type/number_controller.dart';
import 'package:flutter/material.dart';

class CustomRadioButtonWidget extends StatefulWidget {
  final String label;
  final bool? isColumn;

  const CustomRadioButtonWidget({
    super.key,
    required this.label,
    this.isColumn,
  });

  @override
  State<CustomRadioButtonWidget> createState() =>
      _CustomRadioButtonWidgetState();
}

class _CustomRadioButtonWidgetState extends State<CustomRadioButtonWidget> {
  final options = {1: 'Yes', 2: 'No'};
  final controller = NumberController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmallTitle(title: widget.label),
        (widget.isColumn == null || widget.isColumn == false)
            ? Row(children: _getChildern())
            : Column(children: _getChildern()),
      ],
    );
  }

  List<Widget> _getChildern() {
    return options.entries.map((e) {
      return GestureDetector(
        onTap: () {
          setState(() {
            controller.value = e.key;
          });
        },
        child: Row(
          children: [
            Radio(
              value: e.key,
              groupValue: controller.value,
              onChanged: (value) {
                setState(() {
                  controller.value = value ?? 0;
                });
              },
            ),
            Text(e.value),
          ],
        ),
      );
    }).toList();
  }
}

class SmallTitle extends StatelessWidget {
  final String title;

  const SmallTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
