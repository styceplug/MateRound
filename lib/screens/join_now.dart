import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate_round/routes/routes.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';

class JoinNow extends StatelessWidget {
  const JoinNow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.lightGreen,
                  AppColors.darkGreen,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: -(Dimensions.screenHeight / 26.62),
            left: -(Dimensions.screenWidth / 11.62),
            child: Image.asset(
              'assets/images/Rectangle 47.png',
              width: Dimensions.screenWidth / 2.56,
              height: Dimensions.screenHeight / 4.198,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: Dimensions.screenHeight / 6.85,
            left: -(Dimensions.screenWidth / 11.62),
            child: Image.asset(
              'assets/images/Rectangle 43.png',
              width: Dimensions.screenWidth / 2.56,
              height: Dimensions.screenHeight / 4.198,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: -(Dimensions.screenHeight / 11.65),
            left: Dimensions.screenWidth / 4.526,
            child: Image.asset(
              'assets/images/Rectangle 49.png',
              width: Dimensions.screenWidth / 3.739,
              height: Dimensions.screenHeight / 4.198,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: Dimensions.screenHeight / 15.533,
            left: Dimensions.screenWidth / 6.142,
            child: Image.asset(
              'assets/images/Rectangle 48.png',
              width: Dimensions.screenWidth / 2.56,
              height: Dimensions.screenHeight / 4.198,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: Dimensions.screenHeight / 3.883,
            left: Dimensions.screenWidth / 6.142,
            child: Image.asset(
              'assets/images/Rectangle 50.png',
              width: Dimensions.screenWidth / 2.56,
              height: Dimensions.screenHeight / 4.198,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: Dimensions.screenHeight / 11.65,
            left: Dimensions.screenWidth / 1.56,
            child: Image.asset(
              'assets/images/love_vector.png',
              width: Dimensions.screenWidth / 9.87,
              height: Dimensions.screenHeight / 15.533,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: Dimensions.screenHeight / 5.482,
            left: Dimensions.screenWidth / 2.057,
            child: Image.asset(
              'assets/images/Rectangle 51.png',
              width: Dimensions.screenWidth / 2.56,
              height: Dimensions.screenHeight / 4.198,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: -(Dimensions.screenHeight / 10.965),
            left: Dimensions.screenWidth / 1.323,
            child: Image.asset(
              'assets/images/Rectangle 54.png',
              width: Dimensions.screenWidth / 2.56,
              height: Dimensions.screenHeight / 4.198,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: Dimensions.screenHeight / 8.5,
            left: Dimensions.screenWidth / 1.39,
            child: Image.asset(
              'assets/images/Rectangle 52.png',
              width: Dimensions.screenWidth / 2.56,
              height: Dimensions.screenHeight / 4.198,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: Dimensions.screenHeight / 3.214,
            left: Dimensions.screenWidth / 1.39,
            child: Image.asset(
              'assets/images/Rectangle 53.png',
              width: Dimensions.screenWidth / 2.56,
              height: Dimensions.screenHeight / 4.198,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: Dimensions.screenHeight / 2.193,
            left: Dimensions.screenWidth / 28.667,
            child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.screenHeight / 31.067,
              ),
              width: Dimensions.screenWidth / 1.4,
              height: Dimensions.screenHeight / 5.899,
              child: Text(
                "Find your partner in life",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.screenHeight / 23.3,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          Positioned(
            top: Dimensions.screenHeight / 1.503,
            left: Dimensions.screenWidth / 28.667,
            child: SizedBox(
              width: Dimensions.screenWidth / 1.132,
              height: Dimensions.screenHeight / 9.32,
              child: Text(
                'We created to bring together amazing singles who want to find love, laughter and happily ever after! ',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: Dimensions.screenHeight / 51.778,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Positioned(
            bottom: Dimensions.screenHeight / 7.169,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.getCreateAccount());
                },
                child: Container(
                  width: Dimensions.screenWidth / 1.229,
                  height: Dimensions.screenHeight / 14.338,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        Dimensions.screenHeight / 62.1333),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      'Join now',
                      style: TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: Dimensions.screenHeight / 46.6,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: Dimensions.screenHeight / 12.4367,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: Dimensions.screenWidth / 1.229,
                height: Dimensions.screenHeight / 37.28,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.getLogin());
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.screenHeight / 51.778,
                            ),
                          ),
                          TextSpan(
                            text: 'Log in',
                            style: TextStyle(
                              color: Colors.white,
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
