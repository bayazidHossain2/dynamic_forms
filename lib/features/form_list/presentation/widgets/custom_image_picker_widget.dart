import 'dart:typed_data';

import 'package:dynamic_forms/core/theme/app_pallete.dart';
import 'package:dynamic_forms/features/form_list/domain/entities/field_properties.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePickerWidget extends StatefulWidget {
  final FieldProperties fieldProperties;
  final List<Uint8List> imageController;

  const CustomImagePickerWidget({
    super.key,
    required this.fieldProperties,
    required this.imageController,
  });

  @override
  State<CustomImagePickerWidget> createState() =>
      _CustomImagePickerWidgetState();
}

class _CustomImagePickerWidgetState extends State<CustomImagePickerWidget> {
  final controller = TextEditingController();

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
          TextFormField(
            // enabled: false,
            controller: controller,
            onTap: () {
              _showImageUploadDialog(context);
              print('image pic clicked');
            },
            onChanged: (value) {
              controller.text = '';
              _showImageUploadDialog(context);
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppPallete.grey),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ), // Default border color
              ),

              suffixIcon: Icon(Icons.image_outlined, color: AppPallete.grey),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              // focusColor: ,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showImageUploadDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Profile Picture'),
          // backgroundColor: primary,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: AppPallete.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Take a picture',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      _pickImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                Container(
                  decoration: BoxDecoration(
                    color: AppPallete.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Select from gallery',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (result != null) {
      // final bytes = await _image.readAsBytes();
      // final base64Image = base64Encode(bytes);
      // Send the image to the server
      print("Image found");
    }
  }

  Future _pickImage(ImageSource imageSource) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile == null) return null;
    print('\n path is : pickedFile.path');
    final bytes = await pickedFile.readAsBytes();
    if (!widget.fieldProperties.multiImage!) {
      widget.imageController.clear();
    }
    widget.imageController.add(bytes);
    setState(() {
      controller.text = '${widget.imageController.length} image added';
    });
    // await _sendToServer(base64Encode(bytes));
    // return base64Encode(bytes);
  }
}
