import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate_round/controllers/expectations_controller.dart';
import 'package:mate_round/routes/routes.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';
import 'package:mate_round/widgets/expectation_circles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Expectations extends StatefulWidget {
  const Expectations({
    Key? key,
  }) : super(key: key);

  @override
  State<Expectations> createState() => _ExpectationsState();
}

class _ExpectationsState extends State<Expectations>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double progress = 0.0;

  bool _isLoading = false;

  Map<int, String> expectationsList = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: progress).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  void incrementProgress(String title, int id, int level, bool isSelected) {
    if (isSelected) {
      expectationsList[id] = title;
      setState(() {
        if (level == 3) {
          progress += 1 / 4;
        } else if (level == 2) {
          progress += 1 / 5;
        } else if (level == 1) {
          progress += 1 / 6;
        }
      });
    } else {
      expectationsList.remove(id);
      setState(() {
        if (level == 3) {
          progress -= 1 / 4;
        } else if (level == 2) {
          progress -= 1 / 5;
        } else if (level == 1) {
          progress -= 1 / 6;
        }
      });
    }

    _animation = Tween<double>(begin: _animation.value, end: progress)
        .animate(_controller);
    _controller.forward(from: 0.0);
  }

  void continueClick() async {
    if (progress < 1) {
      if (expectationsList.values.toList().isEmpty) {
        Get.snackbar(
            "You should expect more", "You mean you dont expect anything?😳");
      } else if (expectationsList.values.toList().length < 2) {
        Get.snackbar("You should expect more",
            "Just one might not get you the right choice😏");
      } else if (expectationsList.values.toList().length < 3) {
        Get.snackbar("You should expect more", "Add more, it feels good!🤗");
      } else {
        Get.snackbar("You should expect more", "Hmmmmm, almost there!🫣");
      }
    } else {
      ExpectationsController expectationsController = ExpectationsController();
      var expectations = expectationsList.values.toList();
      setState(() {
        _isLoading = true;
      });
      var response =
          await expectationsController.submitExpectations(expectations);

      if (!response['error']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setBool('expectationsSet', true);

        setState(() {
          _isLoading = false;
        });

        Get.offNamed(AppRoutes.getHomeScreen());
      } else {
        // Get.snackbar('Error', response['message']);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void skipPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('expectationsSet', true);

    Get.offNamed(AppRoutes.getHomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColors.ppWhite,
            child: Container(
              margin: EdgeInsets.only(
                left: Dimensions.screenWidth / 21.5,
                right: Dimensions.screenWidth / 21.5,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: Dimensions.screenHeight / 18.64,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: skipPressed,
                      child: const Text('Skip',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  ProgressBar(progress: _animation.value),
                  SizedBox(
                    height: Dimensions.screenHeight / 46.6,
                  ),
                  Text(
                    'What are your \nexpectations?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.screenHeight / 35.846,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight / 46.6,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Stack(
                        children: [
                          Positioned(
                            top: Dimensions.screenHeight / 38.333,
                            left: Dimensions.screenWidth / 86,
                            child: Level3Circle(
                              id: 1,
                              title: 'Long term \nrelationship',
                              onTap: (isSelected) => incrementProgress(
                                  'Long term relationship', 1, 3, isSelected),
                            ),
                          ),
                          Positioned(
                            top: Dimensions.screenHeight / 62.133,
                            left: Dimensions.screenWidth / 2.966,
                            child: Level2Circle(
                              id: 2,
                              title: 'Vacation',
                              onTap: (isSelected) => incrementProgress(
                                  'Vacation', 2, 2, isSelected),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Level3Circle(
                              id: 3,
                              title: 'Romance',
                              onTap: (isSelected) => incrementProgress(
                                  'Romance', 3, 3, isSelected),
                            ),
                          ),
                          Positioned(
                            top: Dimensions.screenHeight / 5.482,
                            left: 0,
                            child: Level2Circle(
                              id: 4,
                              title: 'Secret \nmeetings',
                              onTap: (isSelected) => incrementProgress(
                                  'Secret meetings', 4, 2, isSelected),
                            ),
                          ),
                          Positioned(
                            top: Dimensions.screenHeight / 6.517,
                            left: Dimensions.screenWidth / 4.3,
                            child: Level3Circle(
                              id: 5,
                              title: 'Start a \nfamily',
                              onTap: (isSelected) => incrementProgress(
                                  'Start a family', 5, 3, isSelected),
                            ),
                          ),
                          Positioned(
                            top: Dimensions.screenHeight / 8.473,
                            left: Dimensions.screenWidth / 2.028,
                            child: Level1Circle(
                              id: 6,
                              title: 'Chat',
                              onTap: (isSelected) => incrementProgress(
                                  'Long term \nrelationship', 6, 1, isSelected),
                            ),
                          ),
                          Positioned(
                            top: Dimensions.screenHeight / 6.563,
                            right: 0,
                            child: Level2Circle(
                              id: 7,
                              title: 'friends \n with \nbenefit',
                              onTap: (isSelected) => incrementProgress(
                                  'Friends with benefit', 7, 2, isSelected),
                            ),
                          ),
                          Positioned(
                            top: Dimensions.screenHeight / 3.655,
                            left: Dimensions.screenWidth / 1.483,
                            child: Level2Circle(
                              id: 8,
                              title: 'Friends \nfirst',
                              onTap: (isSelected) => incrementProgress(
                                  'Friends first', 8, 2, isSelected),
                            ),
                          ),
                          Positioned(
                            top: Dimensions.screenHeight / 4.142,
                            left: Dimensions.screenWidth / 1.83,
                            child: Level1Circle(
                              id: 9,
                              title: 'Masculine \nonly',
                              onTap: (isSelected) => incrementProgress(
                                  'Masculine only', 9, 1, isSelected),
                            ),
                          ),
                          Positioned(
                            top: Dimensions.screenHeight / 3.389,
                            left: 0,
                            child: Level3Circle(
                              id: 10,
                              title: 'Active \npartner',
                              onTap: (isSelected) => incrementProgress(
                                  'Active partner', 10, 3, isSelected),
                            ),
                          ),
                          Positioned(
                            top: Dimensions.screenHeight / 3.270,
                            left: Dimensions.screenWidth / 2.966,
                            child: Level2Circle(
                              id: 11,
                              title: 'Casual \ndating',
                              onTap: (isSelected) => incrementProgress(
                                  'Casual dating', 11, 2, isSelected),
                            ),
                          ),
                          Positioned(
                            top: Dimensions.screenHeight / 2.663,
                            right: Dimensions.screenWidth / 10.75,
                            child: Level2Circle(
                              id: 12,
                              title: 'Roleplay \ncostumes',
                              onTap: (isSelected) => incrementProgress(
                                  'Roleplay costumes', 12, 2, isSelected),
                            ),
                          ),
                          Positioned(
                            bottom: Dimensions.screenHeight / 15.5,
                            left: Dimensions.screenWidth / 43.0,
                            child: Level1Circle(
                              id: 13,
                              title: 'BDSM',
                              onTap: (isSelected) =>
                                  incrementProgress('BDSM', 13, 1, isSelected),
                            ),
                          ),
                          Positioned(
                            bottom: Dimensions.screenHeight / 13.314,
                            left: Dimensions.screenWidth / 5.375,
                            child: Level2Circle(
                              id: 14,
                              title: 'Experiments \nopen',
                              onTap: (isSelected) => incrementProgress(
                                  'Experiments open', 14, 2, isSelected),
                            ),
                          ),
                          Positioned(
                            bottom: Dimensions.screenHeight / 37.28,
                            left: Dimensions.screenWidth / 2.389,
                            child: Level2Circle(
                              id: 15,
                              title: 'Sugar \ndaddy',
                              onTap: (isSelected) => incrementProgress(
                                  'Sugar daddy', 15, 2, isSelected),
                            ),
                          ),
                          Positioned(
                            bottom: Dimensions.screenHeight / 18.64,
                            left: Dimensions.screenWidth / 1.433,
                            child: Level1Circle(
                              id: 16,
                              title: 'Don\'t \nknow',
                              onTap: (isSelected) => incrementProgress(
                                  "Don't know", 16, 1, isSelected),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight / 46.6,
                  ),
                  GestureDetector(
                    onTap: () {
                      continueClick();
                    },
                    child: Container(
                      height: Dimensions.screenHeight / 15.533,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                        left: Dimensions.screenWidth / 21.5,
                        right: Dimensions.screenWidth / 21.5,
                        top: Dimensions.screenHeight / 93.2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lilacPurple,
                        borderRadius: BorderRadius.circular(
                            Dimensions.screenHeight / 62.133),
                      ),
                      child: Center(
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.screenHeight / 51.778,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight / 18.64,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ProgressBar extends StatelessWidget {
  final double progress;

  const ProgressBar({super.key, required this.progress});

  double getWidth(BuildContext context) {
    double calculatedWidth = (MediaQuery.of(context).size.width -
            ((Dimensions.screenWidth / 21.5) * 2)) *
        progress;

    if (calculatedWidth < 0) {
      calculatedWidth = 0;
    }

    return calculatedWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      color: Colors.grey,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 2,
          width: getWidth(context),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.darkGreen, AppColors.lightGreen],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
    );
  }
}
