import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate_round/routes/routes.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.screenHeight / 5.497,
                ),
                Container(
                  height: Dimensions.screenHeight / 5.325,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/logo.png',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height20),
                Text(
                  'Search, Chat, Meet & Date',
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: Dimensions.screenHeight / 3.408,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width30),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Find Your Perfect soul mate near you!!!',
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: Dimensions.font30,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(height: Dimensions.height20*2),

                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.getLogin());
                  },
                  child: Container(
                    alignment: Alignment.center,
                   height: Dimensions.height54,
                    width: Dimensions.width100*3,
                    decoration:  BoxDecoration(
                      color: AppColors.greyBackground,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child: Text('Find Someone today',style: TextStyle(color: AppColors.primaryColor,fontSize: Dimensions.font18,fontWeight: FontWeight.w500),),
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
