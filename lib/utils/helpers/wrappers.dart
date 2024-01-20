import 'package:flutter/material.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:ocean_guard/utils/styles/text.dart';

class AppWrappers {
  static void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static Widget inputFieldWrapper(Widget child) => Container(
    padding: const EdgeInsets.all(15.0),
    decoration: const BoxDecoration(
        color: AppColors.myTextBoxGray,
        borderRadius: BorderRadius.all(Radius.circular(5.0))),
    child: child,
  );
}
