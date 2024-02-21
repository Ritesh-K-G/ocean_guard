import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as location_package;
import 'package:geocoding/geocoding.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:ocean_guard/features/authentication/MainAuthScreen.dart';
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
  late location_package.LocationData _currentLocation;
  late StreamSubscription<location_package.LocationData> _locationSubscription;
  late String address = '';
  late Map<String, dynamic> userData = {};
  late bool serverCalled = false;

  void _initLocationService() async {
    final location = location_package.Location();
    location.requestPermission().then((granted) {
      if (granted == location_package.PermissionStatus.granted) {
        _locationSubscription = location.onLocationChanged.listen((location_package.LocationData result) {
          _currentLocation = result;
          convertCoordinatesToAddress(result.latitude!, result.longitude!);
        });
      }
    });
  }

  void convertCoordinatesToAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        if(mounted) {
          setState(() {
            serverCalled = true;
            address = '${place.subLocality}, ${place.locality}';
          });
        }
      }
    } catch (e) {
      print("Error converting coordinates to address: $e");
    }
  }

  Future<void> fetchCardDetails() async {
    final dio = Dio();
    final userID = FirebaseAuth.instance.currentUser?.uid;
    final cards = await dio.get('https://backend-kb2pqsadra-et.a.run.app/getUserDetails?user=$userID');
    print(cards.data);
    userData = cards.data;
    _initLocationService();
  }

  @override
  void initState() {
    super.initState();
    fetchCardDetails();
  }


  @override
  Widget build(BuildContext context) {
    return serverCalled == false
        ? Center(child: CircularProgressIndicator())
        : myBuild();
  }

  Widget myBuild() {
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
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              userData['profilePic']
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
                  Text(
                    userData['firstName'] + ' ' + userData['lastName'],
                    style: TextStyle(
                      fontFamily: 'Hind',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.email ?? '',
                    style: TextStyle(
                      fontFamily: 'Hind',
                      fontSize: 16.0,
                      color: AppColors.myCommentGray,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                          Icons.location_on_rounded,
                          color: AppColors.myPurpleBlue
                      ),
                      Text(
                        address,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                      width: AppHelpers.screenWidth(context) * 0.9,
                      height: AppHelpers.screenHeight(context) * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: const showMap()
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
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // Navigate to the login screen after logout
                Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen()));
              },
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