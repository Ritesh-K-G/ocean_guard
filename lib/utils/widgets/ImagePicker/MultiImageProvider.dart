import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:ocean_guard/utils/helpers/AppHelpers.dart';
import 'package:ocean_guard/utils/helpers/validators.dart';
import 'package:provider/provider.dart';

class MultiImageUploader extends StatelessWidget {
  const MultiImageUploader({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> images = Provider.of<MultiImageProvider>(context).fetchImageList;

    return SizedBox(
        width: AppHelpers.screenWidth(context),
        height: 120,
        child: Row(
          children: [
            ImageUploader(),
            Consumer<MultiImageProvider>(builder: (context, provider, child) {
              return Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.getImagelistSize(),
                      itemBuilder: (context, index) {
                        return ImageContainer(index: index);
                      })
              );
            }),
            if (AppValidators.validateAtLeastOneImage(images))
              const Text(
                'Please add at least one image',
                style: TextStyle(color: Colors.red),
              )
          ],
        )
    );
  }
}

class ImageUploader extends StatelessWidget {
  ImageUploader({super.key});

  File? imageFile;

  Future getImagePath() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemp = File(image.path);
      imageFile = imageTemp;
    } catch (e) {
      print(e);
      print('Not able to fetch image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MultiImageProvider>(builder: (context, provider, child) {
      return GestureDetector(
          onTap: () async {
            await getImagePath();
            if (imageFile == null) return;
            provider.addImage(imageFile!);
            imageFile = null;
          },
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.boxgray,
            ),
            child: const Icon(
              Icons.camera_alt,
              color: Colors.black,
            ),
          )
      );
    });
  }
}

class ImageContainer extends StatelessWidget {
  int index = 0;
  ImageContainer({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<MultiImageProvider>(builder: (context, provider, child) {
      return Stack(
        children: [
          Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(left: 5.0, top: 10.0, right: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.file(
                  provider.getImage(index),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              )
          ),
          Positioned(top: 0, right: 0,
              child: GestureDetector(
                  onTap: () {
                    provider.deleteImage(index);
                  },
                  child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black),
                      child: const Icon(Icons.close, color: Colors.white)
                  )
              ))
        ],
      );
    });
  }
}

class MultiImageProvider extends ChangeNotifier {
  final List<dynamic> _images = [];

  List<dynamic> get fetchImageList => _images;

  void addImage(File image) {
    _images.add(image);
    notifyListeners();
  }

  void deleteImage(int index) {
    _images.removeAt(index);
    notifyListeners();
  }

  File getImage(int index) {
    return _images[index];
  }

  int getImagelistSize() {
    return _images.length;
  }

  void clearImageList() {
    _images.clear();
    notifyListeners();
  }

  bool hasAtLeastOneImage() {
    return _images.isNotEmpty;
  }
}