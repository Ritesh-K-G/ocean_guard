import 'package:flutter/material.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:ocean_guard/features/map/showMap.dart';
import 'package:ocean_guard/utils/helpers/AppHelpers.dart';
import 'package:ocean_guard/utils/styles/button.dart';
import 'package:ocean_guard/utils/styles/text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: AppColors.myPurpleBlue),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                              )
                            ],
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/ishaan.jfif',
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: AppColors.myPurpleBlue,
                              ),
                              color: Colors.blue,
                            ),
                            child: const InkWell(
                              onTap: null,
                              child: Icon(
                                Icons.edit,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Ishaan Oberoi',
                      style: TextStyle(
                        fontFamily: 'Hind',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'ishaan.oberoi@gmail.com',
                      style: TextStyle(
                        fontFamily: 'Hind',
                        fontSize: 16.0,
                        color: AppColors.myCommentGray,
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                            Icons.location_on_rounded,
                            color: AppColors.myPurpleBlue
                        ),
                        Text(
                          'Address',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: AppHelpers.screenWidth(context) * 0.9,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      child: showMap()
                    ),
                  ],
                ),
        )),
        Column(
          children: [
            const SizedBox(height: 5),
            const ListTile(
              leading: Icon(Icons.forum),
              title: Text('Forum'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: null,
            ),
            ElevatedButton(
              onPressed: null,
              style: AppButtonStyles.authButtons.copyWith(
                backgroundColor: const MaterialStatePropertyAll(AppColors.myBlue),
                minimumSize: MaterialStatePropertyAll(
                  Size(AppHelpers.screenWidth(context) * 0.8, 50),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: const Text(
                "Log Out",
                style: AppTextStyles.buttontext,
              ),
            ),
          ],
        ),
      ],
    );
  }
}