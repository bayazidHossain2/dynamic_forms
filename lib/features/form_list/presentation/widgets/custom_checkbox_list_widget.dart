import 'package:dynamic_forms/core/utils/data_type/bool_controller.dart';
import 'package:dynamic_forms/features/form_list/domain/entities/field_properties.dart';
import 'package:dynamic_forms/features/form_list/presentation/widgets/custom_checkbox_widget.dart';
import 'package:flutter/cupertino.dart';

class CustomCheckboxListWidget extends StatefulWidget {
  final FieldProperties fieldProperties;

  const CustomCheckboxListWidget({super.key, required this.fieldProperties});

  @override
  State<CustomCheckboxListWidget> createState() =>
      _CustomCheckboxListWidgetState();
}

class _CustomCheckboxListWidgetState extends State<CustomCheckboxListWidget> {
  List<BoolController> controllerList = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.fieldProperties.listItems!.length; i++) {
      controllerList.add(BoolController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.fieldProperties.label.toString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 4),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.fieldProperties.listItems?.length,
            itemBuilder: (context, index) => CustomCheckboxWidget(
              text: widget.fieldProperties.listItems![index].name,
              controller: controllerList[index],
            ),
          ),
        ],
      ),
    );
  }
}
