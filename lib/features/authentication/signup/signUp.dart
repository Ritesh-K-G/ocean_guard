import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:ocean_guard/features/authentication/signup/cleanerAddress.dart';
import 'package:ocean_guard/navbar.dart';
import 'package:ocean_guard/utils/helpers/AppHelpers.dart';
import 'package:ocean_guard/utils/helpers/validators.dart';
import 'package:ocean_guard/utils/helpers/wrappers.dart';
import 'package:ocean_guard/utils/styles/button.dart';
import 'package:ocean_guard/utils/styles/text.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool asyncCall = false;
  bool isCleaner = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
          child: Column(children: [
        Form(
            key: _formKey,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: AppHelpers.screenWidth(context) * 0.4,
                    decoration: const BoxDecoration(
                      color: AppColors.myTextBoxGray,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                          hintText: "First Name",
                          border: InputBorder.none,
                          errorMaxLines: 3),
                      style: AppTextStyles.formInputTextStyle,
                      validator: AppValidators.validateName,
                    ),
                  ),
                  Container(
                    width: AppHelpers.screenWidth(context) * 0.4,
                    decoration: const BoxDecoration(
                      color: AppColors.myTextBoxGray,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                          hintText: "Last Name",
                          border: InputBorder.none,
                          errorMaxLines: 3),
                      style: AppTextStyles.formInputTextStyle,
                      validator: AppValidators.validateName,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AppWrappers.inputFieldWrapper(TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    hintText: "yourmail@oceanGuard.com",
                    border: InputBorder.none,
                    errorMaxLines: 2),
                style: AppTextStyles.formInputTextStyle,
                validator: AppValidators.validateEmail,
              )),
              const SizedBox(height: 20),
              AppWrappers.inputFieldWrapper(
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "Passcode",
                    border: InputBorder.none,
                    errorMaxLines: 3,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(
                          (hidePassword) ? Iconsax.eye : Iconsax.eye_slash4,
                          color: Colors.black,
                        )),
                  ),
                  style: AppTextStyles.formInputTextStyle,
                  obscureText: hidePassword,
                  validator: (value) => AppValidators.validatePassword(value),
                ),
              ),
              const SizedBox(height: 20),
              AppWrappers.inputFieldWrapper(
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    hintText: "Confirm passcode",
                    border: InputBorder.none,
                    errorMaxLines: 3,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hideConfirmPassword = !hideConfirmPassword;
                          });
                        },
                        icon: Icon(
                          (hideConfirmPassword)
                              ? Iconsax.eye
                              : Iconsax.eye_slash4,
                          color: Colors.black,
                        )),
                  ),
                  style: AppTextStyles.formInputTextStyle,
                  obscureText: hideConfirmPassword,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: AppHelpers.screenWidth(context) * 0.7,
                    child: const Text(
                      "Choose the user Type:",
                      style: AppTextStyles.formLabelStyle,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isCleaner = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.myTextBoxGray,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: isCleaner
                                  ? Colors.amber
                                  : AppColors.myPurpleBlue,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: isCleaner
                                  ? Colors.amber
                                  : AppColors.myPurpleBlue,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Resolver',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isCleaner
                                    ? Colors.amber
                                    : AppColors.myPurpleBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isCleaner = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.myTextBoxGray,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: isCleaner
                                  ? AppColors.myPurpleBlue
                                  : Colors.amber,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 33),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: isCleaner
                                  ? AppColors.myPurpleBlue
                                  : Colors.amber,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'User',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isCleaner
                                    ? AppColors.myPurpleBlue
                                    : Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        if (isCleaner) {
                          final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          final userId=credential.user?.uid;
                          final userData = {
                            'firstName': _firstNameController.text,
                            'lastName': _lastNameController.text,
                            'authority': 1,
                            'pic':"gs://oceanguard-5aea0.appspot.com/icon.jfif"
                          };

                          // Store additional user data in Firestore
                          await FirebaseFirestore.instance.collection('users').doc(userId).set(userData);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CleanerAddress()),
                          );
                        } else {
                          final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          final userId=credential.user?.uid;
                          final userData = {
                            'firstName': _firstNameController.text,
                            'lastName': _lastNameController.text,
                            'authority': 2,
                            'pic':"gs://oceanguard-5aea0.appspot.com/icon.jfif"
                          };

                          // Store additional user data in Firestore
                          await FirebaseFirestore.instance.collection('users').doc(userId).set(userData);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Navbar()),
                          );
                        }
                      } catch (e) {
                        // Handle error
                        print(e);
                      }
                    },

                    style: AppButtonStyles.authButtons.copyWith(
                      minimumSize: MaterialStatePropertyAll(
                          Size(AppHelpers.screenWidth(context) * 0.8, 50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: asyncCall
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Continue",
                            style: AppTextStyles.buttontext,
                          ),
                  ),
                ],
              )
            ])),
        const SizedBox(height: 30),
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
                Text("Or"),
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
                    onPressed: () async {
                      isCleaner == true
                          ?
                      (

                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text).then((value) =>

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const CleanerAddress()))))

                      )
                          :
                      (
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text).then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Navbar()))))

                      );

                    },
                    style: AppButtonStyles.googleButton.copyWith(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ))),
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
                    ))
              ],
            ),
            const SizedBox(height: 10)
          ],
        )
      ])),
    );
  }
}
