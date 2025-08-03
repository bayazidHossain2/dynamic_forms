import 'package:dynamic_forms/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class Snackbar {
  static void show({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    int durationInSecond = 3,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: Duration(seconds: durationInSecond),
          content: Text(message),
          backgroundColor: (backgroundColor == null)
              ? AppPallete.acceptColor
              : backgroundColor,
        ),
      );
  }
}
