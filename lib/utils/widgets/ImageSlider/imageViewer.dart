import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:photo_view/photo_view.dart';

class PhotoScreen extends StatelessWidget {
  String image;
  PhotoScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left, color: AppColors.boxgray),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            'View Image',
                            style: TextStyle(
                                fontFamily: 'Hind',
                                fontWeight: FontWeight.bold,
                                color: AppColors.boxgray,
                                fontSize: 20
                            ),
                          ),
                        ],
                      )
                  ),
                  Expanded(
                      child: PhotoView(
                          imageProvider: CachedNetworkImageProvider(
                              image
                          ),
                          maxScale: 0.8,
                          minScale: 0.2,
                          enableRotation: false
                      )
                  )
                ]
            )
        )
    );
  }
}