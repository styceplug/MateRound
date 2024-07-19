import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate_round/controllers/profile_controller.dart';
import 'package:mate_round/routes/routes.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';
import 'package:mate_round/widgets/step_indicator.dart';
import 'package:mate_round/widgets/update_info.dart';
import 'package:mate_round/widgets/upload_avartar.dart';
import 'package:mate_round/widgets/verify_email.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  bool _isLoading = false;
  int currentStep = 1;

  File? _selectedImage;
  bool _isImageUploaded = false;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();
  final birthdayController = TextEditingController();
  DateTime? birthday;
  String? gender;
  String? height;
  String? hairColor;
  bool _isInfoUploaded = false;

  int otpTimer = 0;
  int otpMaxAttempts = 5;
  bool isOTPSent = false;
  bool isResend = false;
  TextEditingController otpController = TextEditingController();
  bool _isOTPVerified = false;

  final profileController = ProfileController();

  void _previousStep() {
    if (currentStep > 1) {
      setState(() {
        currentStep--;
      });
    } else {
      if (Platform.isAndroid) {
        exit(0);
      }
    }
  }

  void _nextStep() async {
    if (currentStep < 3) {
      setState(() {
        currentStep++;
      });
    } else if (currentStep == 3) {
      if (!_isImageUploaded) {
        Get.snackbar("Error", "You must upload your image.");
      } else if (!_isInfoUploaded) {
        Get.snackbar("Error", "You must fill in your information.");
      } else if (!_isOTPVerified) {
        Get.snackbar("Error", "You must verify your OTP.");
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setBool('isProfileComplete', true);

        Get.offAllNamed(AppRoutes.getExpectations());
      }
    }
  }

  void onImageSelected(File image) {
    setState(() {
      _selectedImage = image;
    });
  }

  void uploadImageClick() async {
    if (_selectedImage == null) {
      Get.snackbar('Error', 'Please select an image before uploading.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    var response = await profileController.uploadImage(_selectedImage!);

    if (!response['error']) {
      setState(() {
        _isImageUploaded = true;
      });
      setState(() {
        _isLoading = false;
      });
      _nextStep();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
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

    setState(() {
      _isLoading = true;
    });

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
      _isInfoUploaded = true;
      setState(() {
        _isLoading = false;
      });
      _nextStep();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void onOtpTimerTick() {
    setState(() {
      otpTimer--;
    });
  }

  void onOtpTimerFinish() {
    setState(() {
      isOTPSent = false;
    });
  }

  void sendOtp() async {
    setState(() {
      _isLoading = true;
    });
    var response = await profileController.sendOtp();

    if (!response['error']) {
      setState(() {
        isOTPSent = true;
        otpTimer = 120;
        setState(() {
          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void verifyOtp() async {
    String otp = otpController.text;
    if (RegExp(r"^\d{6}$").hasMatch(otp)) {
      setState(() {
        _isLoading = true;
      });
      var result = await profileController.verifyOtp(otp);
      if (result['error'] == false) {
        _isOTPVerified = true;
        setState(() {
          _isLoading = false;
        });
        _nextStep();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      Get.snackbar("Error", "Invalid OTP. It must be exactly 6 digits.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.whiteColor,
                  AppColors.gWhite,
                  AppColors.gWhite,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
              // top space
              SizedBox(
                height: Dimensions.screenHeight / 18.64,
              ),
              // the app logo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: Dimensions.screenHeight / 9.32,
                    width: Dimensions.screenWidth / 4.3,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                  ),
                ],
              ),
              // step indicators
              StepIndicator(currentStep: currentStep),
              Expanded(
                child: Center(
                  child: currentStep == 1
                      ? UploadAvatar(
                          selectedImage: _selectedImage,
                          onImageSelected: onImageSelected,
                          onUploadButtonPressed: uploadImageClick,
                        )
                      : currentStep == 2
                          ? UpdateInfo(
                              firstNameController: firstNameController,
                              lastNameController: lastNameController,
                              usernameController: usernameController,
                              bioController: bioController,
                              birthdayController: birthdayController,
                              onBirthdayChanged: (date) {
                                setState(() {
                                  birthday = date;
                                });
                              },
                              onGenderChanged: (value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                              onHeightChanged: (value) {
                                setState(() {
                                  height = value;
                                });
                              },
                              onHairColorChanged: (value) {
                                setState(() {
                                  hairColor = value;
                                });
                              },
                              onSubmit: infoSubmit,
                            )
                          : VerifyEmail(
                              sendOTP: sendOtp,
                              verifyOTP: verifyOtp,
                              otpController: otpController,
                              timer: otpTimer,
                              maxAttempts: otpMaxAttempts,
                              isOTPSent: isOTPSent,
                              isResend: isResend,
                              onTimerTick: onOtpTimerTick,
                              onTimerFinish: onOtpTimerFinish,
                            ),
                ),
              ),
              _isLoading
                  ? const CircularProgressIndicator(
                      color: AppColors.lilacPurple,
                    )
                  : const SizedBox.shrink(),
              // back and forward buttons
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.screenWidth / 8.6,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _previousStep();
                      },
                      child: Container(
                        height: Dimensions.screenHeight / 26.629,
                        width: Dimensions.screenWidth / 5.375,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.screenHeight / 93.2),
                          color: AppColors.greyPurple,
                        ),
                        child: Center(
                          child: Text(
                            currentStep == 1 ? 'BACK' : 'PREVIOUS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: Dimensions.screenHeight / 66.429,
                            ),
                          ),
                        ),
                      ),
                    ),
                    !_isImageUploaded && currentStep == 1
                        ? const SizedBox.shrink()
                        : GestureDetector(
                            onTap: () {
                              _nextStep();
                            },
                            child: Container(
                              height: Dimensions.screenHeight / 26.629,
                              width: Dimensions.screenWidth / 5.375,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.screenHeight / 93.2),
                                color: AppColors.lilacPurple,
                              ),
                              child: Center(
                                child: Text(
                                  currentStep == 3 ? 'DONE' : 'NEXT',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: Dimensions.screenHeight / 66.429,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.screenHeight / 18.64),
            ],
          ),
        ],
      ),
    );
  }
}
