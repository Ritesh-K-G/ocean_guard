import 'package:flutter/material.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:ocean_guard/utils/helpers/AppHelpers.dart';
import 'package:ocean_guard/utils/widgets/ImageSlider/imageSlider.dart';
import 'package:ocean_guard/utils/widgets/paraPrint/description.dart';

class query extends StatefulWidget {
  final String itemID;
  const query({super.key, required this.itemID});

  @override
  State<query> createState() => _queryState();
}

class _queryState extends State<query> {
  Map<String, dynamic>? _itemDetails;
  late String itemAddress = 'Jhalwa,Prayagraj';
  late String _userID;
  late String description;
  List<String> imageUrls = [
    'assets/image/ishaan.jfif',
    'assets/image/ishaan.jfif',
    'assets/image/ishaan.jfif',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
                children: [
                  ImageSliderWidget(
                      imageUrls: imageUrls
                  ),
                  const SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: AppHelpers.screenWidth(context)*0.7,
                                ),
                                child: const Text(
                                  'Query',
                                  style: TextStyle(fontFamily: 'Hind', fontSize: 24, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                ),
                              ),
                            )
                          ]
                      )
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                  ),
                                  Text(
                                    'Ishaan Oberoi',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    '9 / 10 (Urgency Level)',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ]
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: AppColors.myPurple,
                            ),
                            SizedBox(
                                width: AppHelpers.screenWidth(context) * 0.8,
                                child: const Text(
                                  'Delhi',
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                                )
                            )
                          ]
                      )
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                  ),
                  const DescriptionCard(title: 'Description', initialDescription: 'Hehe'),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Status: ',
                          style: TextStyle(fontFamily: 'Hind', fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.myPurpleBlue),
                        ),
                        Text(
                          'Not Resolved',
                          style: TextStyle(fontFamily: 'Hind', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                  )
                ])),
      ),
    );
  }
}