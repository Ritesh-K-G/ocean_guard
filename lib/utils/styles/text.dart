import 'package:flutter/material.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:ocean_guard/constants/sizes.dart';

class AppTextStyles {

  static const TextStyle authHeader = TextStyle(
      color: AppColors.white,
      fontSize: AppSizes.headingmd,
      fontFamily: 'HindJalandhar',
      fontWeight: FontWeight.w700);

  static const TextStyle authTabButtons = TextStyle(
    color: AppColors.white,
    fontSize: AppSizes.sm, // replaced from .lg
    fontFamily: 'Hind',
    fontWeight: FontWeight.normal, // instead of w400
  );

  static const TextStyle authTabButtonsUnselected = TextStyle(
    color: AppColors.myCommentGray,
    fontSize: AppSizes.sm, // replaced from .lg
    fontFamily: 'Hind',
    fontWeight: FontWeight.normal, // instead of w400
  );

  static const TextStyle formLabelStyle = TextStyle(
    color: AppColors.myCommentGray,
    fontFamily: 'Karla',
    fontSize: AppSizes.sm,
  );

  static const TextStyle formInputTextStyle = TextStyle(
    fontFamily: 'Hind',
    fontSize: AppSizes.md,
  );

  static const TextStyle formbluesmall = TextStyle(
    color: Colors.blue,
    fontFamily: 'Karla',
    fontSize: AppSizes.sm,
  );

  static const TextStyle buttontext = TextStyle(
    fontSize: AppSizes.lg,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    letterSpacing: 1.0,
  );

  static const TextStyle signUpTopHeader = TextStyle(
      color: AppColors.darkBlue,
      fontSize: AppSizes.headingmd,
      fontFamily: 'HindJalandhar',
      fontWeight: FontWeight.w800);

  static const TextStyle signUpHeader = TextStyle(
      color: AppColors.darkBlue,
      fontSize: AppSizes.xl,
      fontFamily: 'HindJalandhar',
      fontWeight: FontWeight.w500);

  static const TextStyle dropdownText = TextStyle(
    color: Colors.black,
    fontSize: AppSizes.md,
    fontFamily: 'Hind',
  );

  static const TextStyle fadedTextsm = TextStyle(
    color: Color(0xFF7D7F88),
    fontFamily: 'Hind',
    fontSize: AppSizes.xs,
  );

  static const TextStyle fadedTextmd = TextStyle(
    color: Color(0xFF7D7F88),
    fontFamily: 'Inter',
    fontSize: AppSizes.md,
  );
}
