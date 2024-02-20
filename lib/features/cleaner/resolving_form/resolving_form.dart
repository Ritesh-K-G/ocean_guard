import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:ocean_guard/features/map/showMap.dart';
import 'package:ocean_guard/utils/helpers/AppHelpers.dart';
import 'package:ocean_guard/utils/styles/button.dart';
import 'package:ocean_guard/utils/styles/text.dart';
import 'package:ocean_guard/utils/widgets/ImagePicker/MultiImageProvider.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class resolveForm extends StatefulWidget {
  const resolveForm({super.key});

  @override
  State<resolveForm> createState() => _resolveForm();
}
class _resolveForm extends State<resolveForm> {
  late LocationData _currentLocation;
  late StreamSubscription<LocationData> _locationSubscription;
  final _formkey = GlobalKey<FormState>();
  String userID = "";

  void _initLocationService() {
    final location = Location();
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.granted) {
        _locationSubscription = location.onLocationChanged.listen((LocationData result) {
          setState(() {
            _currentLocation = result;
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initLocationService();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> imageList =
        Provider.of<MultiImageProvider>(context).fetchImageList;
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ocean Guard', style: AppTextStyles.signUpTopHeader),
                  const Text('Help us to clean the ocean for life under water :)',
                      style: AppTextStyles.fadedTextmd),
                  const SizedBox(height: 20),
                  Form(
                      key: _formkey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              'Upload marked zone images',
                              style: AppTextStyles.formLabelStyle,
                            ),
                            const SizedBox(height: 20),
                            const MultiImageUploader(),
                            Container(
                                width: AppHelpers.screenWidth(context) * 0.9,
                                height: AppHelpers.screenHeight(context) * 0.7,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                child: showMap()
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Consumer<MultiImageProvider>(builder: (context, provider, child) {
                                  return ElevatedButton(
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const AlertDialog(
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CircularProgressIndicator(),
                                                  SizedBox(height: 16),
                                                  Text('Uploading data...'),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                        if (_formkey.currentState!.validate() &&
                                            imageList.isNotEmpty) {
                                          List<String> imageUrls = [];

                                          Reference storageReference = FirebaseStorage
                                              .instance.ref().child('queries/');

                                          for (int i = 0; i < imageList.length; i++) {
                                            String fileExtension = imageList[i].path
                                                .split('.')
                                                .last;
                                            String timestamp = DateTime.now()
                                                .toIso8601String();
                                            String fileName = 'query_$timestamp' + '_' +
                                                '$i.$fileExtension';
                                            Reference imageRef = storageReference.child(
                                                fileName);
                                            await imageRef.putFile(imageList[i]);
                                            String imageUrl = await imageRef
                                                .getDownloadURL();
                                            imageUrls.add(imageUrl);
                                          }

                                          final dio = Dio();
                                          print(await dio.post('https://backend-kb2pqsadra-et.a.run.app/addComplaint', data: {
                                            'images': imageUrls,
                                            'latitude': _currentLocation.latitude,
                                            'longitude': _currentLocation.longitude,
                                            'user': 'Ishaan'
                                          }));
                                          provider.clearImageList();
                                          Navigator.pop(context);
                                        };

                                      },
                                      style: AppButtonStyles.authButtons.copyWith(
                                          backgroundColor: const MaterialStatePropertyAll(AppColors.myBlue),
                                          minimumSize: MaterialStatePropertyAll(
                                              Size(AppHelpers.screenWidth(context) * 0.8, 50)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              )
                                          )
                                      ),
                                      child: const Text(
                                        "Submit",
                                        style: AppTextStyles.buttontext,
                                      )
                                  );}
                                ),
                              ],
                            ),
                          ]
                      )
                  )
                ]
            )
        )
    );
  }
}