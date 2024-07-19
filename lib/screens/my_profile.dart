import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mate_round/controllers/profile_controller.dart';
import 'package:mate_round/routes/routes.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';
import 'package:mate_round/widgets/build_circle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final profileController = ProfileController();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();
  final birthdayController = TextEditingController();
  DateTime? birthday;
  String? gender;
  String? height;
  String? hairColor;
  String? displayPicture;

  File? _selectedImage;
  bool _isImageUploaded = false;

  @override
  void initState() {
    super.initState();
    fetchProfileDetails();
  }

  void fetchProfileDetails() async {
    final url = Uri.parse('https://materound.com/app/api/v1/profile/get_profile_details.php');

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? -1;

    try {
      final response = await http.post(url, body: {
        'userId': userId.toString(),
      });

      print(response.body);

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);

        setState(() {
          firstNameController.text = userData['first_name'];
          lastNameController.text = userData['last_name'];
          usernameController.text = userData['username'];
          bioController.text = userData['about'];
          // birthdayController.text = userData['birthday'];
          birthday = DateTime.parse(userData['birthday']);
          gender = userData['gender'];
          height = userData['height'];
          hairColor = userData['hair_color'];
          displayPicture = userData['avater'];
        });
      } else {
        Get.snackbar('Error', 'Failed to fetch profile details');
      }
    } catch (exception) {
      Get.snackbar('Error', 'An error occurred while fetching profile details');
    }
  }

  void onImageSelected(File image) {
    setState(() {
      _selectedImage = image;
    });
  }

  Future<void> _pickImage() async {
    File? _imageFile;
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });
        onImageSelected(_imageFile!);
      }
    } catch (e) {
      print(e);
    }
  }

  void uploadImageClick() async {
    if (_selectedImage == null) {
      // Get.snackbar('Error', 'Please select an image before uploading.');
      return;
    }

    var response = await profileController.uploadImage(_selectedImage!);

    if (!response['error']) {
      _isImageUploaded = true;
    } else {}
  }

  void infoSubmit() async {
    if (firstNameController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your first name.',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (lastNameController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your last name.',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (usernameController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your username.',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (bioController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your bio.',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (birthday == null) {
      Get.snackbar(
        'Error',
        'Please select your birthday.',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (gender == null || gender!.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select your gender.',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (height == null || height!.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select your height.',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (hairColor == null || hairColor!.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select your hair color.',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    uploadImageClick();

    var response = await profileController.submitUserInfo(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      username: usernameController.text,
      bio: bioController.text,
      birthday: birthday!,
      gender: gender!,
      height: height!,
      hairColor: hairColor!,
    );

    if (!response['error']) {
      // Get.offNamed(AppRoutes.getHomeScreen());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // background
          Container(
            decoration: const BoxDecoration(
              color: AppColors.ppWhite,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //top space
                Container(
                  height: Dimensions.screenHeight / 9.32,
                ),
                //my profile and menu
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.screenWidth / 21.5,
                    right: Dimensions.screenWidth / 21.5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //My Profile
                      Text(
                        'My Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.screenHeight / 31.067,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      //four dots
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.getMenuScreen());
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: Dimensions.screenHeight / 31.067,
                          width: Dimensions.screenWidth / 14.333,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const BuildCircle(),
                                  SizedBox(
                                    width: Dimensions.screenWidth / 71.667,
                                  ),
                                  const BuildCircle(),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.screenHeight / 155.333,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const BuildCircle(),
                                  SizedBox(
                                    width: Dimensions.screenWidth / 71.667,
                                  ),
                                  const BuildCircle(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //sized box
                SizedBox(
                  height: Dimensions.screenHeight / 37.28,
                ),
                //long horizontal line
                Container(
                  width: double.maxFinite,
                  height: Dimensions.screenHeight / 1242.667,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                //sized box
                SizedBox(
                  height: Dimensions.screenHeight / 37.28,
                ),
                //profile content
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // profile image and circle around
                      Container(
                        height: Dimensions.screenHeight / 5.648,
                        width: Dimensions.screenWidth / 2.606,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.lighterGold,
                            width: Dimensions.screenWidth / 86,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Center(
                          // the profile image
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              height: Dimensions.screenHeight / 6.213,
                              width: Dimensions.screenWidth / 2.867,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: _selectedImage == null
                                      ? NetworkImage(
                                          'https://materound.com/auth/$displayPicture',
                                        )
                                      : FileImage(_selectedImage!)
                                          as ImageProvider,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //sized box
                      SizedBox(
                        height: Dimensions.screenHeight / 93.2 * 2,
                      ),
                      // first name and last name
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
                            // height
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  hintText:  height != null && height != "" ? height :'Height',
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
                                onChanged: (value) {
                                  setState(() {
                                    height = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: Dimensions.screenWidth / 21.5),
                            // hair color
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  hintText: hairColor != null && hairColor != "" ? hairColor : 'Hair Color',
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
                                onChanged: (value) {
                                  setState(() {
                                    hairColor = value;
                                  });
                                },
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
                            // gender
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  hintText: gender != null && gender != "" ? gender : 'Gender',
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
                                onChanged: (value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: Dimensions.screenWidth / 21.5),
                            // birthday
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
                                            onDateTimeChanged:
                                                (DateTime newdate) {
                                              (newdate) {
                                                setState(() {
                                                  birthday = newdate;
                                                });
                                              };
                                              birthdayController.text =
                                                  DateFormat.yMd()
                                                      .format(newdate);
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
                                      builder:
                                          (BuildContext context, Widget? child) {
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
                                      (picked) {
                                        setState(() {
                                          birthday = picked;
                                        });
                                      };
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
                                        vertical:
                                            Dimensions.screenHeight / 62.133,
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
                          left: Dimensions.screenWidth / 21.5 / 1.5,
                          right: Dimensions.screenWidth / 21.5 / 1.5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: infoSubmit,
                              child: Container(
                                width: Dimensions.screenWidth / 2.15 * 1.5,
                                height: Dimensions.screenHeight / 18.64,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.lilacPurple,
                                ),
                                child:  Center(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.screenHeight / 93.2 * 1.5,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
