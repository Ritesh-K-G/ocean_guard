import 'package:flutter/material.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:ocean_guard/features/map/showMap.dart';
import 'package:ocean_guard/utils/helpers/AppHelpers.dart';
import 'package:ocean_guard/utils/helpers/wrappers.dart';
import 'package:ocean_guard/utils/styles/button.dart';
import 'package:ocean_guard/utils/styles/text.dart';
import 'package:ocean_guard/utils/widgets/ImagePicker/MultiImageProvider.dart';
import 'package:ocean_guard/utils/widgets/Maps/map.dart';

class QueryForm extends StatefulWidget {
  const QueryForm({super.key});

  @override
  State<QueryForm> createState() => _QueryFormState();
}
class _QueryFormState extends State<QueryForm> {
  double _sliderValue = 1.0;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  ElevatedButton(
                      onPressed: null,
                      style: AppButtonStyles.authButtons.copyWith(
                          backgroundColor: const MaterialStatePropertyAll(AppColors.myBlue),
                          minimumSize: MaterialStatePropertyAll(
                              Size(AppHelpers.screenWidth(context) * 0.9, 50)),
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
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}