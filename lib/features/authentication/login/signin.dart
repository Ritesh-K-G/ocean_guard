import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ocean_guard/features/authentication/provider/pageProvider.dart';
import 'package:ocean_guard/features/cleaner/cleaner_navbar.dart';
import 'package:ocean_guard/navbar.dart';
import 'package:ocean_guard/utils/helpers/AppHelpers.dart';
import 'package:ocean_guard/utils/helpers/validators.dart';
import 'package:ocean_guard/utils/helpers/wrappers.dart';
import 'package:ocean_guard/utils/styles/button.dart';
import 'package:ocean_guard/utils/styles/text.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

import '../../super_admin/admin_navbar.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, Key? Key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _signinEmailKey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool asyncCall = false;
  bool hidePassword = true;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInPageProvider>(builder: (context, provider, child) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: _signinEmailKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "EMAIL",
                      style: AppTextStyles.formLabelStyle,
                    ),
                    AppWrappers.inputFieldWrapper(TextFormField(
                      controller: _emailcontroller,
                      decoration: const InputDecoration(
                          hintText: "Your Email", border: InputBorder.none),
                      style: AppTextStyles.formInputTextStyle,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          AppValidators.validateEmail(value),
                    )),
                    const SizedBox(height: 20),
                    const Text(
                      "PASSWORD",
                      style: AppTextStyles.formLabelStyle,
                    ),
                    AppWrappers.inputFieldWrapper(
                      TextFormField(
                        controller: _passwordcontroller,
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            icon: Icon(
                              (hidePassword)
                                  ? Iconsax.eye
                                  : Iconsax.eye_slash4,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        style: AppTextStyles.formInputTextStyle,
                        obscureText: hidePassword,
                        validator: (value) =>
                            AppValidators.validatePassword(value),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: asyncCall
                              ? null
                              : () async {
                            final FirebaseAuth _auth = FirebaseAuth.instance;
      try {
      // Sign in the user with email and password
      final userCredential = await _auth.signInWithEmailAndPassword(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
      );
      final userId=userCredential.user?.uid;

      try {
        // Get the reference to the document in the "user" collection
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();

        // Check if the document exists
        if (userSnapshot.exists) {
          // Retrieve the value of the "authority" field
          final authority = userSnapshot.get('authority');
          if(authority==0)
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => adminNavbar()));
            }
          else if(authority==1)
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => cleanerNavbar()));
            }
          else if(authority==2)
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Navbar()));
            }
        } else {
          // Document doesn't exist
          print('Document does not exist');
          return null;
        }
      } catch (e) {
        // Handle errors
        print('Error fetching user authority: $e');
        return null;
      }

      } catch (e) {
      // Handle sign-in errors
      print("Sign-in error: $e");
      // Show a snackbar or dialog to display the error to the user
      }

                              },
                          style: AppButtonStyles.authButtons.copyWith(
                            minimumSize: MaterialStatePropertyAll(Size(
                                AppHelpers.screenWidth(context) * 0.8, 50)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child: asyncCall
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                            "Login",
                            style: AppTextStyles.buttontext,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Divider(
                            indent: 20,
                            endIndent: 10,
                          )),
                      Text("Or sign in with"),
                      Expanded(
                          child: Divider(
                            indent: 10,
                            endIndent: 20,
                          )),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => Navbar())));
                          },
                          style: AppButtonStyles.googleButton.copyWith(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/icons/google.png',
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Google',
                                style: AppTextStyles.buttontext,
                              )
                            ],
                          )
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        )
      );
    });
  }
}
