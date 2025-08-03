import 'dart:typed_data';

import 'package:dynamic_forms/core/theme/app_pallete.dart';
import 'package:dynamic_forms/features/form_list/domain/entities/field_properties.dart';
import 'package:flutter/cupertino.dart';

class ImageListViewWidget extends StatelessWidget {
  final FieldProperties properties;
  final List<Uint8List> imageDataList;

  const ImageListViewWidget({
    super.key,
    required this.properties,
    required this.imageDataList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          properties.label.toString(),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
          itemCount: imageDataList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: AppPallete.primary, width: 2),
              ),
              margin: EdgeInsets.all(8),
              child: Image.memory(imageDataList[index]),
            );
          },
        ),
      ],
    );
  }
}
