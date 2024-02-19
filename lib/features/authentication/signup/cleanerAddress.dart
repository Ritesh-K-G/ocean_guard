import 'package:flutter/material.dart';
import 'package:ocean_guard/navbar.dart';
import 'package:ocean_guard/utils/helpers/AppHelpers.dart';
import 'package:ocean_guard/utils/helpers/wrappers.dart';
import 'package:ocean_guard/utils/styles/button.dart';
import 'package:ocean_guard/utils/styles/text.dart';

class CleanerAddress extends StatefulWidget {
  const CleanerAddress({super.key});

  @override
  State<CleanerAddress> createState() => _CleanerAddress();
}

class _CleanerAddress extends State<CleanerAddress> {
  String selectedValue = "Goa Beach";

  bool asyncCall = false;

  final _AddressformKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text('Sign up', style: AppTextStyles.signUpTopHeader),
                const Text('we need something more',
                    style: AppTextStyles.signUpHeader),
                const SizedBox(height: 40),
                SizedBox(
                    width: AppHelpers.screenWidth(context) * 0.9,
                    child: Image.asset(
                      'assets/images/beach.jpeg'
                    ),
                ),
                Form(
                  key: _AddressformKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      AppWrappers.dropdownWrapper(
                        items: [
                          const DropdownMenuItem(
                            value: 'Delhi Beach',
                            child: Text('Delhi Beach',
                                style: AppTextStyles.dropdownText),
                          ),
                          const DropdownMenuItem(
                            value: 'Mumbai Beach',
                            child: Text('Mumbai Beach',
                                style: AppTextStyles.dropdownText),
                          ),
                          const DropdownMenuItem(
                            value: 'Kolkata Beach',
                            child: Text('Kolkata Beach',
                                style: AppTextStyles.dropdownText),
                          ),
                          const DropdownMenuItem(
                            value: 'Goa Beach',
                            child: Text('Goa Beach',
                                style: AppTextStyles.dropdownText),
                          ),
                        ],
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Navbar()));
                            },
                            style: AppButtonStyles.authButtons.copyWith(
                              minimumSize: MaterialStatePropertyAll(Size(
                                  AppHelpers.screenWidth(context) * 0.9, 50)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            child: asyncCall
                                ? const CircularProgressIndicator(color: Colors.white,)
                                : const Text(
                              "Register",
                              style: AppTextStyles.buttontext,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
