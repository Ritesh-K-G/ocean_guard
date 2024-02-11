import 'package:flutter/material.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:ocean_guard/utils/helpers/AppHelpers.dart';
import 'package:ocean_guard/utils/styles/text.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
      alignment: const Alignment(-0.6, 0.0),
      height: AppHelpers.screenHeight(context) * 0.2,
      decoration: const BoxDecoration(
          gradient: AppColors.linearGradient,
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      width: MediaQuery.of(context).size.width,
      child: const Text(
        "Ocean Guard",
        style: AppTextStyles.authHeader,
      ),
    );
  }
}
