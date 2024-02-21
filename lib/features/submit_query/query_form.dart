import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:ocean_guard/features/map/showMap.dart';
import 'package:ocean_guard/utils/helpers/AppHelpers.dart';
import 'package:ocean_guard/utils/helpers/wrappers.dart';
import 'package:ocean_guard/utils/styles/button.dart';
import 'package:ocean_guard/utils/styles/text.dart';
import 'package:ocean_guard/utils/widgets/ImagePicker/MultiImageProvider.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class QueryForm extends StatefulWidget {
  const QueryForm({super.key});

  @override
  State<QueryForm> createState() => _QueryFormState();
}
class _QueryFormState extends State<QueryForm> {
  late LocationData _currentLocation;
  late StreamSubscription<LocationData> _locationSubscription;
  double _sliderValue = 1.0;
  final _formkey = GlobalKey<FormState>();
  String userID = "";
  final TextEditingController _descController = TextEditingController();

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
    _currentLocation = LocationData.fromMap({
      "latitude": 28.7041,
      "longitude": 77.1025,
    });
    _initLocationService();
  }

  @override
  Widget build(BuildContext context) {
    print(_currentLocation);
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
                  AppWrappers.inputFieldWrapper(SizedBox(
                    height: 120,
                    child: TextFormField(
                      controller: _descController,
                      decoration: const InputDecoration(
                        hintText: "Description",
                        border: InputBorder.none,
                      ),
                      style: AppTextStyles.formInputTextStyle,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please provide description'
                          : null,
                    ),
                  )),
                  const SizedBox(height: 20),
                  Text(
                    'Urgency level: $_sliderValue',
                    style: AppTextStyles.formLabelStyle,
                  ),
                  const SizedBox(height: 20.0),
                  Slider(
                    value: _sliderValue,
                    min: 1.0,
                    max: 10.0,
                    divisions: 9,
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Upload Dirty zone images',
                    style: AppTextStyles.formLabelStyle,
                  ),
                  const SizedBox(height: 20),
                  const MultiImageUploader(),
                  Container(
                    width: AppHelpers.screenWidth(context) * 0.9,
                    height: AppHelpers.screenHeight(context) * 0.5,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: const showMap()
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<MultiImageProvider>(
                        builder: (context, provider, child) {
                          return ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate() &&
                                  imageList.isNotEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
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
                                List<String> imageUrls = [];

                                Reference storageReference =
                                FirebaseStorage.instance.ref().child('queries/');

                                for (int i = 0; i < imageList.length; i++) {
                                  String fileExtension =
                                      imageList[i].path.split('.').last;
                                  String timestamp =
                                  DateTime.now().toIso8601String();
                                  String fileName = 'query_$timestamp' +
                                      '_' +
                                      '$i.$fileExtension';
                                  Reference imageRef = storageReference.child(
                                      fileName);
                                  await imageRef.putFile(imageList[i]);
                                  String imageUrl =
                                  await imageRef.getDownloadURL();
                                  imageUrls.add(imageUrl);
                                }

                                final dio = Dio();
                                try {
                                  var res = await dio.post(
                                    'https://backend-kb2pqsadra-et.a.run.app/addComplaint',
                                    data: {
                                      'images': imageUrls,
                                      'latitude': _currentLocation.latitude,
                                      'longitude': _currentLocation.longitude,
                                      'description': _descController.text,
                                      'urgency': _sliderValue,
                                      'user': FirebaseAuth.instance.currentUser?.uid
                                    });
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('Success!!'),
                                  ));
                                }
                                catch(e) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('Bad Request!!'),
                                  ));
                                }finally{
                                  _descController.clear();
                                  _sliderValue = 1.0;
                                  provider.clearImageList();
                                  Navigator.pop(context);
                                }
                              }
                            },
                            style: AppButtonStyles.authButtons.copyWith(
                                backgroundColor:
                                MaterialStateProperty.all(AppColors.myBlue),
                                minimumSize: MaterialStateProperty.all(
                                    Size(AppHelpers.screenWidth(context) *
                                        0.8,
                                        50)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    ))),
                            child: const Text(
                              "Submit",
                              style: AppTextStyles.buttontext,
                            ),
                          );
                        },
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