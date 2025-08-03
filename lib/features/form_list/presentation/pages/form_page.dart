import 'package:dynamic_forms/features/form_list/domain/entities/dynamic_form.dart';
import 'package:dynamic_forms/features/form_list/presentation/widgets/custom_button.dart';
import 'package:dynamic_forms/features/form_list/presentation/widgets/custom_checkbox_list_widget.dart';
import 'package:dynamic_forms/features/form_list/presentation/widgets/custom_dropdown_widget.dart';
import 'package:dynamic_forms/features/form_list/presentation/widgets/custom_image_picker_widget.dart';
import 'package:dynamic_forms/features/form_list/presentation/widgets/custom_radio_button_widget.dart';
import 'package:dynamic_forms/features/form_list/presentation/widgets/custom_text_form_field_with_label_widget.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  final DynamicForm dynamicForm;

  const FormPage({super.key, required this.dynamicForm});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formKey = GlobalKey<FormState>();

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
                                  return CustomTextFormFieldWithLabelWidget(
                                    properties: field.properties,
                                  );
                                } else if (field.properties.type ==
                                    'dropDownList') {
                                  return CustomDropdownWidget(
                                    properties: field.properties,
                                  );
                                } else if (field.properties.type == 'yesno') {
                                  return CustomRadioButtonWidget(
                                    label: field.properties.label.toString(),
                                  );
                                } else if (field.properties.type ==
                                    'checkBoxList') {
                                  return CustomCheckboxListWidget(
                                    fieldProperties: field.properties,
                                  );
                                } else if (field.properties.type ==
                                    'imageView') {
                                  return CustomImagePickerWidget(
                                    fieldProperties: field.properties,
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
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print('--validator pass');
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
