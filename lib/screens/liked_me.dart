import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate_round/routes/routes.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';
import 'package:mate_round/widgets/build_circle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LikedMe extends StatefulWidget {
  const LikedMe({super.key});

  @override
  State<LikedMe> createState() => _LikedMeState();
}

class _LikedMeState extends State<LikedMe> {
  int isPro = 0;
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  void fetchDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? -1;
    int _isPro = prefs.getInt('isPro') ?? 0;

    final url = Uri.parse('https://materound.com/app/api/v1/profile/liked_me.php');
    final response = await http.post(url, body: {'userId': userId.toString()});

    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body);
        isPro = _isPro;
      });
    } else {
      Get.snackbar('Error', 'Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // background
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
          ),
          // content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //top space
              Container(
                height: Dimensions.screenHeight / 9.32,
              ),
              //liked me and menu
              Container(
                margin: EdgeInsets.only(
                  left: Dimensions.screenWidth / 21.5,
                  right: Dimensions.screenWidth / 21.5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //liked me
                    Text(
                      'People that liked me',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.screenHeight / 31.067,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    //four dots
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.getMenuScreen());
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: Dimensions.screenHeight / 31.067,
                        width: Dimensions.screenWidth / 14.333,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const BuildCircle(),
                                SizedBox(
                                  width: Dimensions.screenWidth / 71.667,
                                ),
                                const BuildCircle(),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.screenHeight / 155.333,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const BuildCircle(),
                                SizedBox(
                                  width: Dimensions.screenWidth / 71.667,
                                ),
                                const BuildCircle(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //sized box
              SizedBox(
                height: Dimensions.screenHeight / 37.28,
              ),
              //long horizontal line
              Container(
                width: double.maxFinite,
                height: Dimensions.screenHeight / 1242.667,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
              ),
              // main content
              SingleChildScrollView(
                child: isPro == 5
                    ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.screenHeight / 93.2 * 10,
                      ),
                      // no more matches image
                      Container(
                        height: Dimensions.screenHeight / 3.389,
                        width: Dimensions.screenWidth / 1.564,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/empty_icon.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight / 93.2 * 2,
                      ),
                      // no more matches text
                      Text(
                        'Subscribe to view this',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.screenHeight / 37.28,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight / 93.2 * 2,
                      ),
                      // get premium
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoutes.getPremium());
                        },
                        child: Container(
                          height: Dimensions.screenHeight / 26.629 * 1.5,
                          width: Dimensions.screenWidth / 3.583 * 2,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(
                                Dimensions.screenHeight / 12.4267),
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
                      ),
                    ],
                  ),
                )
                    : users.isEmpty
                    ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.screenHeight / 93.2 * 10,
                      ),
                      // no more matches image
                      Container(
                        height: Dimensions.screenHeight / 3.389,
                        width: Dimensions.screenWidth / 1.564,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/empty_icon.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight / 93.2 * 2,
                      ),
                      // no more matches text
                      Text(
                        'No user likes you yet',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.screenHeight / 37.28,
                        ),
                      ),
                    ],
                  ),
                )
                    : Column(
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight / 1.26,
                      child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, firstIndex) {
                            final index = users.length - 1 - firstIndex;
                            return GestureDetector(
                              onTap: (){
                                Get.toNamed(AppRoutes.getProfileDetailScreen(users[index]['user_id'].toString()));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal:
                                  Dimensions.screenWidth / 43,
                                  vertical:
                                  Dimensions.screenHeight / 466,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical:
                                  Dimensions.screenHeight / 186.4,
                                  horizontal:
                                  Dimensions.screenWidth / 43,
                                ),
                                height:
                                Dimensions.screenHeight / 12.427,
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    Container(
                                      height: Dimensions.screenHeight /
                                          18.64,
                                      width:
                                      Dimensions.screenWidth / 8.6,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primaryColor,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'https://materound.com/auth/${users[index]['avater']}',),
                                            fit: BoxFit.contain,
                                          )),
                                    ),
                                    Container(
                                      width: Dimensions.screenWidth /
                                          1.323,
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                        Dimensions.screenWidth / 43,
                                        vertical:
                                        Dimensions.screenHeight /
                                            186.4,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${users[index]['first_name']} ${users[index]['last_name']}',
                                            style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: Dimensions
                                                .screenHeight /
                                                186.4,
                                          ),
                                          Text(
                                            '${users[index]['created_at']}',
                                            style: const TextStyle(
                                              fontWeight:
                                              FontWeight.normal,
                                            ),
                                            overflow:
                                            TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
