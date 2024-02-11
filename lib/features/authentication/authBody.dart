import 'package:flutter/material.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:ocean_guard/features/authentication/login/signin.dart';
import 'package:ocean_guard/features/authentication/provider/pageProvider.dart';
import 'package:ocean_guard/features/authentication/signup/signUp.dart';
import 'package:ocean_guard/utils/helpers/AppHelpers.dart';
import 'package:ocean_guard/utils/styles/text.dart';
import 'package:provider/provider.dart';

class AuthBody extends StatefulWidget {
  const AuthBody({super.key});

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Widget> signInPages = [const SignIn()];

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int signinPageIndex = Provider.of<SignInPageProvider>(context).signinPageIndex;

    return Column(
      children: [
        Container(
          height: 60.0,
          width: AppHelpers.screenWidth(context) * 0.8,
          padding: const EdgeInsets.only(
              right: 4.0, left: 4.0, top: 4.0, bottom: 4.0),
          decoration: BoxDecoration(
              color: AppColors.myTextBoxGray,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(width: 2.0, color: AppColors.myTextBoxGray)),
          child: TabBar(
              controller: _tabController,
              indicator: const BoxDecoration(
                  gradient: AppColors.linearGradient,
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              dividerColor: Colors.transparent,
              onTap: (value) {
                setState(() {});
              },
              tabs: [
                Tab(
                  child: SizedBox(
                    width: AppHelpers.screenWidth(context) * 0.3,
                    child: Text(
                      "Sign in",
                      style: (_tabController.index == 0)
                          ? AppTextStyles.authTabButtons
                          : AppTextStyles.authTabButtonsUnselected,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Tab(
                  child: SizedBox(
                    width: AppHelpers.screenWidth(context) * 0.3,
                    child: Text("Register",
                        style: (_tabController.index == 1)
                            ? AppTextStyles.authTabButtons
                            : AppTextStyles.authTabButtonsUnselected,
                        textAlign: TextAlign.center),
                  ),
                )
              ]),
        ),
        Container(
          height: AppHelpers.screenHeight(context) * 0.7,
          width: AppHelpers.screenWidth(context),
          padding: const EdgeInsets.all(20.0),
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [signInPages[signinPageIndex], const SignUp()],
          ),
        ),
      ],
    );
  }
}
