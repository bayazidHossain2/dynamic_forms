import 'dart:typed_data';

import 'package:dynamic_forms/core/utils/data_type/bool_controller.dart';
import 'package:dynamic_forms/core/utils/data_type/number_controller.dart';
import 'package:dynamic_forms/features/form_list/domain/entities/dynamic_form.dart';
import 'package:dynamic_forms/features/form_list/presentation/widgets/custom_button.dart';
import 'package:dynamic_forms/features/form_list/presentation/widgets/custom_checkbox_list_widget.dart';
import 'package:dynamic_forms/features/form_list/presentation/widgets/custom_dropdown_widget.dart';
import 'package:dynamic_forms/features/form_list/presentation/widgets/custom_image_picker_widget.dart';
import 'package:dynamic_forms/features/form_list/presentation/widgets/custom_radio_button_widget.dart';
import 'package:dynamic_forms/features/form_list/presentation/widgets/custom_text_form_field_with_label_widget.dart';
import 'package:dynamic_forms/features/form_list/presentation/pages/form_view_page.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  final DynamicForm dynamicForm;

  const FormPage({super.key, required this.dynamicForm});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formKey = GlobalKey<FormState>();
  final Map<String, dynamic> controllerMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(widget.dynamicForm.formName))),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.dynamicForm.sections.length,
                  itemBuilder: (context, index) {
                    final section = widget.dynamicForm.sections[index];
                    return Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
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
                                  controllerMap[field.key] =
                                      TextEditingController();
                                  return CustomTextFormFieldWithLabelWidget(
                                    properties: field.properties,
                                    controller: controllerMap[field.key],
                                  );
                                } else if (field.properties.type ==
                                    'dropDownList') {
                                  controllerMap[field.key] =
                                      TextEditingController();
                                  return CustomDropdownWidget(
                                    properties: field.properties,
                                    controller: controllerMap[field.key],
                                  );
                                } else if (field.properties.type == 'yesno') {
                                  controllerMap[field.key] = NumberController();
                                  return CustomRadioButtonWidget(
                                    label: field.properties.label.toString(),
                                    onSaved: (newValue) {
                                      controllerMap[field.key].value = newValue;
                                    },
                                  );
                                } else if (field.properties.type ==
                                    'checkBoxList') {
                                  List<BoolController> controllers = [];
                                  for (
                                    int i = 0;
                                    i < field.properties.listItems!.length;
                                    i++
                                  ) {
                                    controllers.add(BoolController());
                                  }
                                  controllerMap[field.key] = controllers;
                                  return CustomCheckboxListWidget(
                                    fieldProperties: field.properties,
                                    controller: controllerMap[field.key],
                                  );
                                } else if (field.properties.type ==
                                    'imageView') {
                                  List<Uint8List> dataList = [];
                                  controllerMap[field.key] = dataList;
                                  return CustomImagePickerWidget(
                                    fieldProperties: field.properties,
                                    imageController: controllerMap[field.key],
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
                CustomButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      print('--validator pass');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormViewPage(
                            dynamicForm: widget.dynamicForm,
                            controllerMap: controllerMap,
                          ),
                        ),
                      );
                    } else {
                      print('=---not pass');
                    }
                  },
                  text: 'Submit',
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
