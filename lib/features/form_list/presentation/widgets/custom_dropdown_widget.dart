import 'package:dynamic_forms/core/theme/app_pallete.dart';
import 'package:dynamic_forms/features/form_list/domain/entities/field_properties.dart';
import 'package:dynamic_forms/features/form_list/domain/entities/list_item.dart';
import 'package:flutter/material.dart';

class CustomDropdownWidget extends StatefulWidget {
  final FieldProperties properties;

  const CustomDropdownWidget({super.key, required this.properties});

  @override
  State<CustomDropdownWidget> createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.properties.label.toString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              // color: AppPallete.white,
              border: (_selectedItem == null)
                  ? Border.all(color: AppPallete.primary, width: 1)
                  : Border.all(color: Colors.grey, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectedItem,
                hint: widget.properties.hintText == null
                    ? null
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 8.0,
                        ),
                        child: Text(widget.properties.hintText!),
                      ),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedItem = newValue; // Update the selected value
                  });
                },
                selectedItemBuilder: (BuildContext context) {
                  return widget.properties.listItems!
                      .map<DropdownMenuItem<String>>((ListItem item) {
                        return DropdownMenuItem<String>(
                          value: item.value.toString(),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              item.name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      })
                      .toList();
                },
                items: widget.properties.listItems!
                    .map<DropdownMenuItem<String>>((ListItem item) {
                      return DropdownMenuItem<String>(
                        value: item.value.toString(),
                        child: Text(
                          item.name,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          maxLines: null,
                        ),
                      );
                    })
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
