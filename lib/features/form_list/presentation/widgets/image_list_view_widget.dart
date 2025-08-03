import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class ImageListViewWidget extends StatelessWidget {
  final List<Uint8List> imageDataList;

  const ImageListViewWidget({super.key, required this.imageDataList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imageDataList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8),
          child: Image.memory(imageDataList[index]),
        );
      },
    );
  }
}
