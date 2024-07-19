import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';

class UpdateInfo extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController usernameController;
  final TextEditingController bioController;
  final TextEditingController birthdayController;
  final ValueChanged<DateTime> onBirthdayChanged;
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<String?> onHeightChanged;
  final ValueChanged<String?> onHairColorChanged;
  final VoidCallback onSubmit;

  const UpdateInfo({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
    required this.usernameController,
    required this.bioController,
    required this.birthdayController,
    required this.onBirthdayChanged,
    required this.onGenderChanged,
    required this.onHeightChanged,
    required this.onHairColorChanged,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // first and last name
          Container(
            margin: EdgeInsets.only(
              top: 0,
              left: Dimensions.screenWidth / 21.5,
              right: Dimensions.screenWidth / 21.5,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      hintText: 'First Name',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: Dimensions.screenHeight / 62.133,
                        horizontal: Dimensions.screenWidth / 21.5,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.screenWidth / 430,
                          color: AppColors.mainPurple,
                        ),
                        borderRadius: BorderRadius.circular(
                          Dimensions.screenHeight / 62.133,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.screenWidth / 286.667,
                          color: AppColors.mainPurple,
                        ),
                        borderRadius: BorderRadius.circular(
                          Dimensions.screenHeight / 62.133,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.screenWidth / 21.5),
                Expanded(
                  child: TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: Dimensions.screenHeight / 62.133,
                        horizontal: Dimensions.screenWidth / 21.5,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.screenWidth / 430,
                          color: AppColors.mainPurple,
                        ),
                        borderRadius: BorderRadius.circular(
                          Dimensions.screenHeight / 62.133,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.screenWidth / 286.667,
                          color: AppColors.mainPurple,
                        ),
                        borderRadius: BorderRadius.circular(
                          Dimensions.screenHeight / 62.133,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // username
          Container(
            margin: EdgeInsets.only(
              top: Dimensions.screenHeight / 46.6,
              left: Dimensions.screenWidth / 21.5,
              right: Dimensions.screenWidth / 21.5,
            ),
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: 'Username',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  vertical: Dimensions.screenHeight / 62.133,
                  horizontal: Dimensions.screenWidth / 21.5,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: Dimensions.screenWidth / 430,
                    color: AppColors.mainPurple,
                  ),
                  borderRadius: BorderRadius.circular(
                    Dimensions.screenHeight / 62.133,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: Dimensions.screenWidth / 286.667,
                    color: AppColors.mainPurple,
                  ),
                  borderRadius: BorderRadius.circular(
                    Dimensions.screenHeight / 62.133,
                  ),
                ),
              ),
            ),
          ),
          // username instruction
          Container(
            margin: EdgeInsets.only(
              left: Dimensions.screenWidth / 15,
              right: Dimensions.screenWidth / 21.5,
            ),
            child: const Text(
              'Username cannot contain spaces.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          // height and hair color
          Container(
            margin: EdgeInsets.only(
              top: Dimensions.screenHeight / 46.6,
              left: Dimensions.screenWidth / 21.5,
              right: Dimensions.screenWidth / 21.5,
            ),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Height',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: Dimensions.screenHeight / 62.133,
                        horizontal: Dimensions.screenWidth / 21.5,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.screenWidth / 430,
                          color: AppColors.mainPurple,
                        ),
                        borderRadius: BorderRadius.circular(
                          Dimensions.screenHeight / 62.133,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.screenWidth / 286.667,
                          color: AppColors.mainPurple,
                        ),
                        borderRadius: BorderRadius.circular(
                          Dimensions.screenHeight / 62.133,
                        ),
                      ),
                    ),
                    items: List.generate(
                      49,
                      (index) {
                        int feet = 4 + index ~/ 12;
                        int inches = index % 12;
                        String height = '$feet\'$inches\'\'';
                        return DropdownMenuItem(
                          value: height,
                          child: Text(height),
                        );
                      },
                    ),
                    onChanged: onHeightChanged,
                  ),
                ),
                SizedBox(width: Dimensions.screenWidth / 21.5),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Hair Color',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: Dimensions.screenHeight / 62.133,
                        horizontal: Dimensions.screenWidth / 21.5,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.screenWidth / 430,
                          color: AppColors.mainPurple,
                        ),
                        borderRadius: BorderRadius.circular(
                          Dimensions.screenHeight / 62.133,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.screenWidth / 286.667,
                          color: AppColors.mainPurple,
                        ),
                        borderRadius: BorderRadius.circular(
                          Dimensions.screenHeight / 62.133,
                        ),
                      ),
                    ),
                    items: [
                      'Black',
                      'Brown',
                      'Blonde',
                      'Red',
                      'Grey',
                      'Other',
                    ].map((color) {
                      return DropdownMenuItem(
                        value: color,
                        child: Text(color),
                      );
                    }).toList(),
                    onChanged: onHairColorChanged,
                  ),
                ),
              ],
            ),
          ),
          // gender and birthday
          Container(
            margin: EdgeInsets.only(
              top: Dimensions.screenHeight / 46.6,
              left: Dimensions.screenWidth / 21.5,
              right: Dimensions.screenWidth / 21.5,
            ),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Gender',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: Dimensions.screenHeight / 62.133,
                        horizontal: Dimensions.screenWidth / 21.5,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.screenWidth / 430,
                          color: AppColors.mainPurple,
                        ),
                        borderRadius: BorderRadius.circular(
                          Dimensions.screenHeight / 62.133,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.screenWidth / 286.667,
                          color: AppColors.mainPurple,
                        ),
                        borderRadius: BorderRadius.circular(
                          Dimensions.screenHeight / 62.133,
                        ),
                      ),
                    ),
                    items: [
                      'Male',
                      'Female',
                      'Neutral',
                      'Custom',
                    ].map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: onGenderChanged,
                  ),
                ),
                SizedBox(width: Dimensions.screenWidth / 21.5),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      if (Platform.isIOS) {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext builder) {
                            return SizedBox(
                              height: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height /
                                  3,
                              child: CupertinoDatePicker(
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (DateTime newdate) {
                                  onBirthdayChanged(newdate);
                                  birthdayController.text =
                                      DateFormat.yMd().format(newdate);
                                },
                                minimumYear: 1900,
                                maximumDate: DateTime.now(),
                                mode: CupertinoDatePickerMode.date,
                              ),
                            );
                          },
                        );
                      } else {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now()
                              .subtract(const Duration(days: 6570)),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: AppColors.mainPurple,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          onBirthdayChanged(picked);
                          birthdayController.text =
                              DateFormat.yMd().format(picked);
                        }
                      }
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: birthdayController,
                        decoration: InputDecoration(
                          hintText: 'Birthday',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: Dimensions.screenHeight / 62.133,
                            horizontal: Dimensions.screenWidth / 21.5,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: Dimensions.screenWidth / 430,
                              color: AppColors.mainPurple,
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.screenHeight / 62.133,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: Dimensions.screenWidth / 286.667,
                              color: AppColors.mainPurple,
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.screenHeight / 62.133,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // bio
          Container(
            margin: EdgeInsets.only(
              top: Dimensions.screenHeight / 46.6,
              left: Dimensions.screenWidth / 21.5,
              right: Dimensions.screenWidth / 21.5,
            ),
            child: TextField(
              maxLines: 6,
              controller: bioController,
              decoration: InputDecoration(
                hintText: 'Bio',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  vertical: Dimensions.screenHeight / 62.133,
                  horizontal: Dimensions.screenWidth / 21.5,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: Dimensions.screenWidth / 430,
                    color: AppColors.mainPurple,
                  ),
                  borderRadius: BorderRadius.circular(
                    Dimensions.screenHeight / 62.133,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: Dimensions.screenWidth / 286.667,
                    color: AppColors.mainPurple,
                  ),
                  borderRadius: BorderRadius.circular(
                    Dimensions.screenHeight / 62.133,
                  ),
                ),
              ),
            ),
          ),
          // submit btn
          Container(
            margin: EdgeInsets.only(
              top: Dimensions.screenHeight / 46.6,
              left: Dimensions.screenWidth / 21.5,
              right: Dimensions.screenWidth / 21.5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onSubmit,
                  child: Container(
                    width: Dimensions.screenWidth / 2.15,
                    height: Dimensions.screenHeight / 18.64,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.lilacPurple,
                    ),
                    child: const Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
