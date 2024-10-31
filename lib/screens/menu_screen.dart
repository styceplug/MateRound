import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate_round/controllers/login_controller.dart';
import 'package:mate_round/routes/routes.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';
import 'package:mate_round/widgets/menu_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String firstName = '';
  String lastName = '';
  String displayPicture = '';
  String username = '';
  int isPro = 0;

  final LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final url = Uri.parse(
        'https://materound.com/app/api/v1/profile/get_profile_details.php');
    final prefs = await SharedPreferences.getInstance();

    final userId = prefs.getInt('userId') ?? -1;

    try {
      final response = await http.post(url, body: {
        'userId': userId.toString(),
      });

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);

        setState(() {
          displayPicture = userData['avater'];
          username = userData['username'];
        });
      } else {
        Get.snackbar('Error', 'Failed to fetch profile details');
      }
    } catch (exception) {
      Get.snackbar('Error', 'An error occurred while fetching profile details');
    }
    int _isPro = prefs.getInt('isPro') ?? 0;
    setState(() {
      firstName = prefs.getString('firstName') ?? '';
      lastName = prefs.getString('lastName') ?? '';
      isPro = _isPro;
    });
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed(AppRoutes.getJoinNow());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(
            height: Dimensions.screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //top space
                Container(
                  height: Dimensions.screenHeight / 9.32,
                ),
                //profile container
                Container(
                  height: Dimensions.screenHeight / 15.533,
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.screenWidth / 466,
                  ),
                  child: Row(
                    children: [
                      // close button
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: Dimensions.screenHeight / 26.629,
                          width: Dimensions.screenWidth / 12.286,
                          margin: EdgeInsets.only(
                            left: Dimensions.screenWidth / 43,
                          ),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor,
                                spreadRadius: 0.5,
                                blurRadius: 30,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.close,
                            size: Dimensions.screenHeight / 37.28,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.screenWidth / 43,
                      ),
                      //image
                      Container(
                        width: Dimensions.screenWidth / 12,
                        height: Dimensions.screenHeight / 25,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://materound.com/auth/$displayPicture',
                              ),
                            ),
                          ),
                        ),
                      ),
                      // name and show profile
                      GestureDetector(
                        onTap: () {
                          Get.offNamed(AppRoutes.getMyProfileScreen());
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2.15,
                          margin: EdgeInsets.only(
                            left: Dimensions.screenWidth / 105.5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // name
                              Flexible(
                                child: Text(
                                  username,
                                  style: TextStyle(
                                    fontSize: Dimensions.screenHeight / 65,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // show profile
                              Text(
                                "Show Profile",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: Dimensions.screenHeight / 62.133,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Get premium
                      /*isPro == 0
                          ? GestureDetector(
                              onTap: () {
                                Platform.isIOS
                                    ? Get.snackbar('Open Website',
                                        'You can subscribe for premium by going to our website')
                                    : Get.toNamed(AppRoutes.getPremium());
                              },
                              child: Container(
                                height: Dimensions.screenHeight / 28,
                                width: Dimensions.screenWidth / 3.8,
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.screenHeight / 100),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.primaryColor,
                                      spreadRadius: 0.5,
                                      blurRadius: 12,
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'GET PREMIUM',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),*/
                    ],
                  ),
                ),
                //sections container
                Container(
                  height: Dimensions.screenHeight / 1.286,
                  margin: EdgeInsets.only(
                    top: Dimensions.screenHeight / 46.6,
                    bottom: Dimensions.screenHeight / 46.6,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //find matches
                        MenuItem(
                          onPressed: () {
                            Get.offAllNamed(AppRoutes.getHomeScreen());
                          },
                          img: 'assets/images/Vector-2.png',
                          text: 'Find Matches',
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight / 186.4,
                        ),
                        Container(
                          height: Dimensions.screenHeight / 1864,
                          color: Colors.grey[500],
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.screenWidth / 14.33,
                          ),
                        ),
                        // Messages
                        MenuItem(
                          onPressed: () {
                            Get.offAllNamed(AppRoutes.getMessagesScreen());
                          },
                          img: 'assets/images/Vector-3.png',
                          text: 'Messages',
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight / 186.4,
                        ),
                        Container(
                          height: Dimensions.screenHeight / 1864,
                          color: Colors.grey[500],
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.screenWidth / 14.33,
                          ),
                        ),
                        // friend requests
                        /*MenuItem(
                          onPressed: () {
                            print('Friend requests');
                          },
                          img: 'assets/images/Vector-7.png',
                          text: 'Friend request',
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight / 186.4,
                        ),
                        Container(
                          height: Dimensions.screenHeight / 1864,
                          color: Colors.grey[500],
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.screenWidth / 14.33,
                          ),
                        ),*/
                        // visitors
                        MenuItem(
                          onPressed: () {
                            Get.offAllNamed(AppRoutes.getVisitors());
                          },
                          text: 'Visitors',
                          isIcon: true,
                          icon: Icons.visibility,
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight / 186.4,
                        ),
                        Container(
                          height: Dimensions.screenHeight / 1864,
                          color: Colors.grey[500],
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.screenWidth / 14.33,
                          ),
                        ),
                        //friends
                        /*MenuItem(
                          onPressed: () {
                            print('friends');
                          },
                          img: 'assets/images/Vector.png',
                          text: 'Friends',
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight / 186.4,
                        ),
                        Container(
                          height: Dimensions.screenHeight / 1864,
                          color: Colors.grey[500],
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.screenWidth / 14.33,
                          ),
                        ),*/
                        //people that liked me
                        MenuItem(
                          onPressed: () {
                            Get.offAllNamed(AppRoutes.getLikedMe());
                          },
                          img: 'assets/images/Vector-5.png',
                          text: 'People that liked me',
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight / 186.4,
                        ),
                        Container(
                          height: Dimensions.screenHeight / 1864,
                          color: Colors.grey[500],
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.screenWidth / 14.33,
                          ),
                        ),
                        //people i liked
                        MenuItem(
                          onPressed: () {
                            Get.offAllNamed(AppRoutes.getLikes());
                          },
                          img: 'assets/images/Vector-6.png',
                          text: 'People I liked',
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight / 186.4,
                        ),
                        Container(
                          height: Dimensions.screenHeight / 1864,
                          color: Colors.grey[500],
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.screenWidth / 14.33,
                          ),
                        ),
                        //People I disliked
                        MenuItem(
                          onPressed: () {
                            Get.offAllNamed(AppRoutes.getDisLikes());
                          },
                          img: 'assets/images/Vector-1.png',
                          text: 'People I disliked',
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight / 186.4,
                        ),
                        Container(
                          height: Dimensions.screenHeight / 1864,
                          color: Colors.grey[500],
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.screenWidth / 14.33,
                          ),
                        ),
                        // hot or not
                       /* MenuItem(
                          onPressed: () {
                            Get.snackbar("Coming soon",
                                "Hot or not feature is coming to the mobile app soon");
                          },
                          text: 'Hot or not',
                          isIcon: true,
                          icon: Icons.thumbs_up_down,
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight / 186.4,
                        ),
                        Container(
                          height: Dimensions.screenHeight / 1864,
                          color: Colors.grey[500],
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.screenWidth / 14.33,
                          ),
                        ),*/
                        //deactivate account
                        MenuItem(
                          onPressed: () {
                            Get.dialog(
                              AlertDialog(
                                title: const Text('Deactivate your Account'),
                                content: const Text(
                                  'You are about to deactivate and your account, your data would also be permanently deleted from our database. We would also love some feedback from you on how to improve.',
                                  textAlign: TextAlign.center,
                                ),
                                actions: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      loginController.deactivate();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 10,),
                                      child: const Center(
                                        child: Text(
                                          'Deactivate and Delete Account',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          img: 'assets/images/ddd.png',
                          text: 'Delete Account',
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight / 186.4,
                        ),
                        Container(
                          height: Dimensions.screenHeight / 1864,
                          color: Colors.grey[500],
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.screenWidth / 14.33,
                          ),
                        ),
                        // logout
                        MenuItem(
                          onPressed: logout,
                          isIcon: true,
                          icon: Icons.logout,
                          text: 'Logout',
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight / 186.4,
                        ),
                      ],
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
