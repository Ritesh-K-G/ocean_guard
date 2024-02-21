import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:ocean_guard/features/cleaner/resolving_form/resolving_form.dart';
import 'package:ocean_guard/models/queryModel.dart';
import 'package:ocean_guard/utils/helpers/AppHelpers.dart';
import 'package:ocean_guard/utils/styles/button.dart';
import 'package:ocean_guard/utils/widgets/ImageSlider/imageSlider.dart';
import 'package:ocean_guard/utils/widgets/paraPrint/description.dart';

class queryDescription extends StatefulWidget {
  final QueryModel cardData;
  const queryDescription({super.key, required this.cardData});

  @override
  State<queryDescription> createState() => _queryDescription();
}

class _queryDescription extends State<queryDescription> {

  late QueryModel cardData;

  @override
  void initState() {
    super.initState();
    cardData = widget.cardData;
  }


  @override
  Widget build(BuildContext context) {
    return cardData == null
        ? Center(child: CircularProgressIndicator())
        : myBuild();
  }

  Widget myBuild() {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
                children: [
                  ImageSliderWidget(
                      imageUrls: cardData.resolvedImages + cardData.images
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
                  Padding(
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
                                    Icons.star_rounded,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    '${cardData.urgency} / 10 (Urgency Level)',
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
                                child: Text(
                                  cardData.place,
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
                  DescriptionCard(title: 'Description', initialDescription: cardData.description),
                  const SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Status: ',
                          style: TextStyle(fontFamily: 'Hind', fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.myPurpleBlue),
                        ),
                        cardData.resolved
                            ? Text(
                          'Resolved',
                          style: TextStyle(fontFamily: 'Hind', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                        )
                            : Text(
                          'Not Resolved',
                          style: TextStyle(fontFamily: 'Hind', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => resolveForm(queryID: cardData.queryID)));
                    },
                    style: AppButtonStyles.authButtons.copyWith(
                      backgroundColor: const MaterialStatePropertyAll(AppColors.myPurple),
                      minimumSize: MaterialStatePropertyAll(Size(AppHelpers.screenWidth(context)*0.9, 50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Mark as Resolved",
                      style: TextStyle(
                        fontFamily: 'Hind',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                ])),
      ),
    );
  }
}