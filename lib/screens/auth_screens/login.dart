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

  bool visiblePass = false;
  void viewPassword(){
    visiblePass = !visiblePass;
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
          Get.offAllNamed(AppRoutes.getFloatingBar());
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
    } else {
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
              color: AppColors.backgroundWhite,
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // top space
                  SizedBox(
                    height: Dimensions.height100*1.5,
                  ),

                  //welcome back text
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, Welcome Back! 👋',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: Dimensions.screenHeight / 37.28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accentColor,
                          ),
                        ),
                        Text(
                          "Hello again, you've been missed!",
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: Dimensions.screenHeight / 58.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //email address
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: TextField(
                      controller: emailController,
                      style: TextStyle(
                        fontSize: Dimensions.screenHeight / 62.133,
                        color: AppColors.text,
                      ),
                      cursorColor: AppColors.primaryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Input Username',
                        labelStyle: TextStyle(
                          fontSize: Dimensions.font14,
                          fontWeight: FontWeight.w300,
                          color: AppColors.primaryColor,
                        ),
                        hintText: 'Input Login',
                        hintStyle: TextStyle(
                          fontSize: Dimensions.font14,
                          fontWeight: FontWeight.w300,
                          color: AppColors.text.withOpacity(0.5),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: Dimensions.width5 / Dimensions.width10,
                            color: AppColors.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(Dimensions.radius10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: Dimensions.width5 / Dimensions.width10,
                            color: AppColors.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(Dimensions.radius10),
                        ),
                      ),
                    ),
                  ),
                  // Password
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: TextField(
                      obscureText: visiblePass,
                      controller: passwordController,
                      style: TextStyle(
                        fontSize: Dimensions.screenHeight / 62.133,
                        color: AppColors.text,
                      ),
                      cursorColor: AppColors.primaryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: (){
                            setState(() {
                            viewPassword();
                          });},
                            child: Icon(visiblePass? Icons.visibility_off:Icons.visibility)),
                        alignLabelWithHint: true,
                        labelText: 'Input Password',
                        labelStyle: TextStyle(
                          fontSize: Dimensions.font14,
                          fontWeight: FontWeight.w300,
                          color: AppColors.primaryColor,
                        ),
                        hintText: 'Input Password',
                        hintStyle: TextStyle(
                          fontSize: Dimensions.font14,
                          fontWeight: FontWeight.w300,
                          color: AppColors.text.withOpacity(0.5),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: Dimensions.width5 / Dimensions.width10,
                            color: AppColors.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(Dimensions.radius10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: Dimensions.width5 / Dimensions.width10,
                            color: AppColors.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(Dimensions.radius10),
                        ),
                      ),
                    ),
                  ),
                  // Remember me and forgot password
                  Row(
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
                              fontWeight: FontWeight.w500,
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
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            fontSize: Dimensions.screenHeight / 62.133,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //login button
                  GestureDetector(
                    onTap: _loginClick,
                    child: Container(
                      height: Dimensions.screenHeight / 18.64,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                        top: Dimensions.screenHeight / 93.2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.orangeBtn,
                        borderRadius: BorderRadius.circular(
                            Dimensions.screenHeight / 62.133),
                      ),
                      child: Center(
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.font18,
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
                              color: AppColors.primaryColor,
                              fontSize: Dimensions.font16,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: Dimensions.font16,
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
