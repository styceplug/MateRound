import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate_round/controllers/login_controller.dart';
import 'package:mate_round/routes/routes.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';
import 'package:mate_round/widgets/password_text_field.dart';
import 'package:mate_round/widgets/remember_me_check_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  bool _isLoading = false;

  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.whiteColor,
                  AppColors.primaryColor,
                  AppColors.primaryColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // top space
                SizedBox(
                  height: Dimensions.screenHeight / 18.64,
                ),
                //forgot password Text
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.screenWidth / 21.5,
                    right: Dimensions.screenWidth / 21.5,
                    top: Dimensions.screenHeight / 62.133,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: Dimensions.screenHeight / 37.28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "An email would be sent with the link to reset your password",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: Dimensions.screenHeight / 58.25,
                        ),
                      ),
                    ],
                  ),
                ),
                //email address
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.screenWidth / 21.5,
                    right: Dimensions.screenWidth / 21.5,
                    top: Dimensions.screenHeight / 31.067,
                  ),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email Address',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          fontSize: Dimensions.screenHeight / 51.778,
                        ),
                      ),
                      TextField(
                        controller: emailController,
                        style: TextStyle(
                          fontSize: Dimensions.screenHeight / 62.133,
                          color: Colors.black,
                        ),
                        cursorColor: AppColors.primaryColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: Dimensions.screenHeight / 62.133,
                            horizontal: Dimensions.screenWidth / 21.5,
                          ),
                          hintText: 'Enter your email',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: Dimensions.screenWidth / 430,
                              color: AppColors.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(
                                Dimensions.screenHeight / 62.133),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: Dimensions.screenWidth / 286.667,
                              color: AppColors.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(
                                Dimensions.screenHeight / 62.133),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //send mail button
                GestureDetector(
                  // onTap: _loginClick,
                  child: Container(
                    height: Dimensions.screenHeight / 18.64,
                    width: double.maxFinite,
                    margin: EdgeInsets.only(
                      left: Dimensions.screenWidth / 21.5,
                      right: Dimensions.screenWidth / 21.5,
                      top: Dimensions.screenHeight / 93.2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(
                          Dimensions.screenHeight / 62.133),
                    ),
                    child: Center(
                      child: _isLoading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        'send mail',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.screenHeight / 51.778,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
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
