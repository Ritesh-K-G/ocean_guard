import 'package:flutter/material.dart';

class SignInPageProvider extends ChangeNotifier {
  int _signinPageIndex = 0;

  void setSigninPageIndex(int index) {
    _signinPageIndex = index;
    notifyListeners();
  }

  int get signinPageIndex => _signinPageIndex;
}