import 'package:dynamic_forms/features/form_list/presentation/widgets/image_list_view_widget.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/dynamic_form.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_checkbox_list_widget.dart';
import '../widgets/text_field_widget.dart';

class FormViewPage extends StatelessWidget {
  final DynamicForm dynamicForm;
  final Map<String, dynamic> controllerMap;

  const FormViewPage({
    super.key,
    required this.dynamicForm,
    required this.controllerMap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Form View Page'))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: dynamicForm.sections.length,
              itemBuilder: (context, index) {
                final section = dynamicForm.sections[index];
                return Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: section.fields.length,
                          itemBuilder: (context, index) {
                            final field = section.fields[index];
                            if (field.properties.type == 'text') {
                              return TextFieldWidget(
                                properties: field.properties,
                                controller: controllerMap[field.key],
                              );
                            } else if (field.properties.type ==
                                'dropDownList') {
                              return TextFieldWidget(
                                properties: field.properties,
                                controller: controllerMap[field.key],
                              );
                            } else if (field.properties.type == 'yesno') {
                              return TextFieldWidget(
                                properties: field.properties,
                                controller: TextEditingController(
                                  text: controllerMap[field.key]!.value
                                      .toString(),
                                ),
                              );
                            } else if (field.properties.type ==
                                'checkBoxList') {
                              return CustomCheckboxListWidget(
                                fieldProperties: field.properties,
                                controller: controllerMap[field.key],
                              );
                            }
                            else if (field.properties.type == 'imageView') {
                              return ImageListViewWidget(
                                imageDataList: controllerMap[field.key],
                              );
                            }
                            return Text(field.key);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            CustomButton(onPressed: () async {}, text: 'Save'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
