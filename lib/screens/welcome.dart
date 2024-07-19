import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate_round/routes/routes.dart';
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
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/bg2.jpg',
                ),
                fit: BoxFit.cover,
              ),
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
                        'assets/images/mtmt.png',
                      ),
                    ),
                  ),
                ),
                Container(
                  height: Dimensions.screenHeight / 21.3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/search.png',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.screenHeight / 3.408,
                ),
                Container(
                  height: Dimensions.screenHeight / (932 / 70),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/ff.png',
                      ),
                    ),
                  ),
                ),
                Container(
                  height: Dimensions.screenHeight / 85.2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/line22.png',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.screenHeight / 34.08,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.getLogin());
                  },
                  child: Container(
                    height: Dimensions.screenHeight / 15.49,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/rect.png',
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
