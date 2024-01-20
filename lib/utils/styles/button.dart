import 'package:flutter/material.dart';
import 'package:ocean_guard/constants/color.dart';

class AppButtonStyles {
  static const ButtonStyle authButtons = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(AppColors.myBlue),
    foregroundColor: MaterialStatePropertyAll(AppColors.white),
    fixedSize: MaterialStatePropertyAll(Size(200, 50)),
  );

  static const ButtonStyle googleButton = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(AppColors.white),
    foregroundColor: MaterialStatePropertyAll(AppColors.myBlack),
    side: MaterialStatePropertyAll(BorderSide(color: Colors.black)),
    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0)),
  );
}