import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate_round/controllers/login_controller.dart';
import 'package:mate_round/routes/routes.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';
import 'package:mate_round/widgets/password_text_field.dart';
import 'package:mate_round/widgets/remember_me_check_box.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool remember = false;

  void _onRememberMeChanged(bool isChecked) {
    remember = isChecked;
  }

  final LoginController loginController = Get.put(LoginController());

  void _loginClick() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("Error", "Email and password cannot be empty");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    var result = await loginController.login(
        emailController.text, passwordController.text, remember);

    if (!result['error']) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setBool('remember', remember);
      await prefs.setBool('isProfileComplete', result['isProfileComplete']);

      bool? expectationsSet = result['isExpectationsSet'];

      if (result['isProfileComplete'] == true) {
        if (expectationsSet == true) {
          setState(() {
            _isLoading = false;
          });
          Get.offAllNamed(AppRoutes.getHomeScreen());
        } else {
          setState(() {
            _isLoading = false;
          });
          Get.offAllNamed(AppRoutes.getExpectations());
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        Get.offAllNamed(AppRoutes.getCompleteProfile());
      }
    }else {
      setState(() {
        _isLoading = false;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }


  Future<void> openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
                        'Hi, Welcome Back! 👋',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: Dimensions.screenHeight / 37.28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Hello again, you've been missed!",
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
                                Dimensions.screenHeight / 62.133),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: Dimensions.screenWidth / 286.667,
                              color: AppColors.mainPurple,
                            ),
                            borderRadius: BorderRadius.circular(
                                Dimensions.screenHeight / 62.133),
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
                        hintText: 'Please Enter Your password',
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
                      GestureDetector(
                        onTap: () async {
                          const url = 'https://materound.com/auth/forgot';
                          try {
                            await openLink(url);
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                            fontSize: Dimensions.screenHeight / 62.133,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //login button
                GestureDetector(
                  onTap: _loginClick,
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
                              'login',
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
            top: Dimensions.screenHeight / 1.134,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Get.offNamed(AppRoutes.getCreateAccount());
                },
                child: SizedBox(
                  width: Dimensions.screenWidth / 1.229,
                  height: Dimensions.screenHeight / 37.28,
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Don\'t have an account? ',
                            style: TextStyle(
                              color: AppColors.mainPurple,
                              fontSize: Dimensions.screenHeight / 51.778,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign Up',
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
