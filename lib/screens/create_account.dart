import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate_round/controllers/signup_controller.dart';
import 'package:mate_round/routes/routes.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';
import 'package:mate_round/widgets/password_text_field.dart';
import 'package:mate_round/widgets/remember_me_check_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool _isLoading = false;

  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool remember = false;

  void _onRememberMeChanged(bool isChecked) {
    remember = isChecked;
  }

  var signUpController = Get.put(SignUpController());

  Future<void> signUpClick() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    String country = prefs.getString('country') ?? "Unknown";
    String mobileDeviceId = "Unknown";
    String mobileDevice = "Unknown";

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Error", "Invalid email address");
      return;
    }

    if (password.length < 6) {
      Get.snackbar("Error", "Password must be at least 6 characters long");
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    signUpController.isLoading.value = true;
    setState(() {
      _isLoading = true;
    });

    try {
      var response = await signUpController.signUp(
          email, password, phoneNumber, country, mobileDeviceId, mobileDevice);

      if (!response['error']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString('token', response['token']);
        await prefs.setInt('userId', int.parse(response['userId'].toString()));
        await prefs.setInt('isPro', 0);
        await prefs.setInt('proType', 0);
        await prefs.setBool('remember', remember);
        setState(() {
          _isLoading = false;
        });

        Get.offAllNamed(AppRoutes.completeProfile);
      } else {}
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      signUpController.isLoading.value = false;
    } finally {
      setState(() {
        _isLoading = false;
      });
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
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                //Create an account Text
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
                        'Create an account',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: Dimensions.screenHeight / 37.28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Connect with new people today!',
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
                        cursorColor: AppColors.mainPurple,
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
                    ],
                  ),
                ),
                // Phone number
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
                        'Phone Number',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          fontSize: Dimensions.screenHeight / 51.778,
                        ),
                      ),
                      TextField(
                        controller: phoneNumberController,
                        style: TextStyle(
                          fontSize: Dimensions.screenHeight / 58.25,
                          color: Colors.black,
                        ),
                        cursorColor: AppColors.mainPurple,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: Dimensions.screenHeight / 62.133,
                            horizontal: Dimensions.screenWidth / 21.5,
                          ),
                          hintText: 'Enter your phone number',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
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
                    ],
                  ),
                ),
                // Password
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
                        'Password',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          fontSize: Dimensions.screenHeight / 51.778,
                        ),
                      ),
                      PasswordTextField(
                        passwordController: passwordController,
                        hintText: 'Choose a password',
                      ),
                    ],
                  ),
                ),
                //Confirm Password
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
                        'Confirm Password',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          fontSize: Dimensions.screenHeight / 51.778,
                        ),
                      ),
                      PasswordTextField(
                        passwordController: confirmPasswordController,
                        hintText: "Type in the password again",
                      ),
                    ],
                  ),
                ),
                // Remember me and forgot password
                Container(
                  height: Dimensions.screenHeight / 18.64,
                  margin: EdgeInsets.only(
                    left: Dimensions.screenWidth / 21.5,
                    right: Dimensions.screenWidth / 21.5,
                    top: Dimensions.screenHeight / 93.2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RememberMeCheckbox(
                            onChanged: _onRememberMeChanged,
                          ),
                          Text(
                            'Remember Me',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                              fontSize: Dimensions.screenHeight / 62.133,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          fontSize: Dimensions.screenHeight / 62.133,
                        ),
                      ),
                    ],
                  ),
                ),
                //Sign up button
                GestureDetector(
                  onTap: signUpClick,
                  child: Container(
                    height: Dimensions.screenHeight / 18.64,
                    width: double.maxFinite,
                    margin: EdgeInsets.only(
                      left: Dimensions.screenWidth / 21.5,
                      right: Dimensions.screenWidth / 21.5,
                      top: Dimensions.screenHeight / 93.2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainPurple,
                      borderRadius: BorderRadius.circular(
                          Dimensions.screenHeight / 62.133),
                    ),
                    child: Center(
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Sign Up',
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
          Positioned(
            top: Dimensions.screenHeight / 1.1,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Get.offNamed(AppRoutes.getLogin());
                },
                child: SizedBox(
                  width: Dimensions.screenWidth / 1.229,
                  height: Dimensions.screenHeight / 37.28,
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                              color: AppColors.mainPurple,
                              fontSize: Dimensions.screenHeight / 51.778,
                            ),
                          ),
                          TextSpan(
                            text: 'Log in',
                            style: TextStyle(
                              color: AppColors.mainPurple,
                              fontSize: Dimensions.screenHeight / 51.778,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
