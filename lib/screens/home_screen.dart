import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate_round/controllers/find_matches_controller.dart';
import 'package:mate_round/controllers/like_user_controller.dart';
import 'package:mate_round/controllers/profile_controller.dart';
import 'package:mate_round/routes/routes.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';
import 'package:mate_round/widgets/build_circle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FindMatchesController findMatchesController =
      Get.put(FindMatchesController());
  final LikeUserController likeUserController = Get.put(LikeUserController());
  bool _isLoading = false;

  final profileController = ProfileController();
  String firstName = '';
  String displayPicture = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
    findMatchesController.fetchData();
    preloadImages();
    _showWarningDialogIfNeeded();

  }

  Future<void> _showWarningDialogIfNeeded() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasShownDialog = prefs.getBool('hasShownDialog') ?? false;

    if (!hasShownDialog) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Notice"),
            content: Text("There is no tolerance for objectionable content or abusive users. if you continue, it means you agree to our terms and conditions at materound.com."),
            actions: <Widget>[
              GestureDetector(
                onTap: (){
                  Get.back();
                  // Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.mainPurple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10
                  ),
                  child: const Center(
                    child: Text('Agree',
                      style: TextStyle(
                        color: Colors.white,
                      ),),
                  ),
                ),
              ),
            ],
          );
        },
      );

      await prefs.setBool('hasShownDialog', true);
    }
  }

  Future<void> loadUserData() async {
    final url = Uri.parse(
        'https://materound.com/app/api/v1/profile/get_profile_details.php');
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? -1;
    int _isPro = prefs.getInt('isPro') ?? 0;
    setState(() {
      firstName = prefs.getString('firstName') ?? '';
    });

    try {
      final response = await http.post(url, body: {
        'userId': userId.toString(),
      });

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);

        setState(() {
          displayPicture = userData['avater'];
          firstName = userData['first_name'];
        });
      } else {
        Get.snackbar('Error', 'Failed to fetch profile details');
      }
    } catch (exception) {
      Get.snackbar('Error', 'An error occurred while fetching profile details');
    }
  }

  void preloadImages() {
    for (var i = 0; i < findMatchesController.data.length; i++) {
      precacheImage(
        NetworkImage(getImageUrlForIndex(i)),
        context,
      );
    }
  }

  String getImageUrlForIndex(int index) {
    if (index >= 0 && index < findMatchesController.data.length) {
      if (findMatchesController.data[index]['avater'] == null ||
          findMatchesController.data[index]['avater'] == '') {
        return '';
      }
      return 'https://materound.com/auth/${findMatchesController.data[index]['avater']}';
    }
    return '';
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed(AppRoutes.getJoinNow());
  }

  int index = 0;

  void increaseIndex() {
    // if (index >= 0 && index < findMatchesController.data.length) {
    setState(() {
      index++;
    });
    //}
  }

  String getFirstName() {
    if (index >= 0 && index < findMatchesController.data.length - 1) {
      if (findMatchesController.data[index]['first_name'] == null ||
          findMatchesController.data[index]['first_name'] == '') {
        return findMatchesController.data[index]['username'];
      }
      return findMatchesController.data[index]['first_name'];
    }
    return '';
  }

  String getLastName() {
    if (index >= 0 && index < findMatchesController.data.length) {
      if (findMatchesController.data[index]['last_name'] == null ||
          findMatchesController.data[index]['last_name'] == '') {
        return findMatchesController.data[index]['username'];
      }
      return findMatchesController.data[index]['last_name'];
    }
    return 'A';
  }

  String getImageUrl() {
    if (index >= 0 && index < findMatchesController.data.length) {
      if (findMatchesController.data[index]['avater'] == null ||
          findMatchesController.data[index]['avater'] == '') {
        return '';
      }
      return 'https://materound.com/auth/${findMatchesController.data[index]['avater']}';
    }
    return '';
  }

  String getCountry() {
    if (index >= 0 && index < findMatchesController.data.length) {
      if (findMatchesController.data[index]['country'] == null ||
          findMatchesController.data[index]['country'] == "") {
        return 'CO';
      }
      return findMatchesController.data[index]['country'];
    }
    return 'CO';
  }

  String getCity() {
    if (index >= 0 && index < findMatchesController.data.length) {
      if (findMatchesController.data[index]['city'] == null ||
          findMatchesController.data[index]['city'] == "") {
        return 'City';
      }
      return findMatchesController.data[index]['city'];
    }
    return 'City';
  }

  String calculateAge(String birthday) {
    if (birthday.isEmpty || birthday == "0000-00-00") {
      return "50";
    }

    DateTime birthDate;
    try {
      if (birthday.contains("T")) {
        birthDate = DateTime.parse(birthday);
      } else {
        birthDate = DateTime.parse("${birthday}T00:00:00.000");
      }

      final currentDate = DateTime.now();
      final age = currentDate.year - birthDate.year;

      if (currentDate.month < birthDate.month ||
          (currentDate.month == birthDate.month &&
              currentDate.day < birthDate.day)) {
        return "${age - 1}";
      } else {
        return "$age";
      }
    } catch (e) {
      return "50";
    }
  }

  String getAge() {
    if (index >= 0 && index < findMatchesController.data.length) {
      final birthday = findMatchesController.data[index]['birthday'];
      final age = calculateAge(birthday);
      return age;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<FindMatchesController>(
        builder: (FindMatchesController controller) {
          return Stack(
            children: [
              // background
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.ppWhite,
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
                  //find match and menu
                  Container(
                    margin: EdgeInsets.only(
                      left: Dimensions.screenWidth / 21.5,
                      right: Dimensions.screenWidth / 21.5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //find match
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(AppRoutes.getMyProfileScreen());
                              },
                              child: Container(
                                width: Dimensions.screenHeight / 14.2,
                                height: Dimensions.screenWidth / 6.55,
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.normalGreen,
                                    width: 3,
                                  ),
                                  // image: DecorationImage(image: NetworkImage(getImageUrl()))
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
                            ),
                            SizedBox(
                              width: Dimensions.screenWidth / 39.3,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hello  $firstName', style: const TextStyle(
                                  color: Colors.black,
                                ),),
                                const Text(
                                  'Let\'s find a match',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Text(
                        //   'Find Match',
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: Dimensions.screenHeight / 31.067,
                        //     fontFamily: 'Poppins',
                        //   ),
                        // ),
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
                  if (_isLoading)
                    const  LinearProgressIndicator(
                        color: AppColors.mainPurple,
                        backgroundColor: AppColors.lilacPurple,
                      ),
                  //sized box
                  SizedBox(
                    height: Dimensions.screenHeight / 37.28,
                  ),
                  /* //location
                  Container(
                    margin: EdgeInsets.only(
                      left: Dimensions.screenWidth / 14.333,
                    ),
                    child: Text(
                      'Location',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Dimensions.screenHeight / 62.133,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  //sized box
                  SizedBox(
                    height: Dimensions.screenHeight / 62.133,
                  ),
                  //location
                  Obx(() {
                    if (findMatchesController.data.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (index == findMatchesController.data.length) {
                      return const SizedBox.shrink();
                    } else {
                      // location
                      return Container(
                        margin: EdgeInsets.only(
                          left: Dimensions.screenWidth / 14.333,
                        ),
                        child: Text(
                          '     ${getCountry()}    ',
                          style: TextStyle(
                            fontSize: Dimensions.screenHeight / 29.125,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  }),
                  //sized box
                  SizedBox(
                    height: Dimensions.screenHeight / 18.64,
                  ),
                  // main container
                  if (controller.isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    Obx(() {
                      if (findMatchesController.data.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
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
                                'No more Matches',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.screenHeight / 37.28,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (index == findMatchesController.data.length ||
                          findMatchesController.data == []) {
                        // no more matches
                        return Center(
                          child: Column(
                            children: [
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
                                'No more Matches',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.screenHeight / 37.28,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // main container
                        return Container(
                          height: Dimensions.screenHeight / 1.864,
                          width: double.maxFinite,
                          margin: EdgeInsets.only(
                            left: Dimensions.screenWidth / 21.5,
                            right: Dimensions.screenWidth / 21.5,
                          ),
                          //main stack
                          child: Stack(
                            children: [
                              Center(
                                //images stack
                                child: Stack(
                                  children: [
                                    // right side transform
                                    Transform.rotate(
                                      angle: 0.25,
                                      child: Container(
                                        height: Dimensions.screenHeight / 2.663,
                                        width: Dimensions.screenWidth / 1.564,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(
                                            Dimensions.screenHeight / 46.6,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 5,
                                              blurRadius: 5,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // left side transform
                                    Transform.rotate(
                                      angle: -0.25,
                                      child: Container(
                                        height: Dimensions.screenHeight / 2.663,
                                        width: Dimensions.screenWidth / 1.564,
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey[200],
                                          borderRadius: BorderRadius.circular(
                                            Dimensions.screenHeight / 46.6,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 5,
                                              blurRadius: 5,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // fore ground Stack
                                    Stack(
                                      children: [
                                        //fore ground image
                                        Container(
                                          height:
                                              Dimensions.screenHeight / 2.663,
                                          width: Dimensions.screenWidth / 1.564,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              Dimensions.screenHeight / 46.6,
                                            ),
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.white,
                                            ),
                                            image: DecorationImage(
                                              image:
                                                  NetworkImage(getImageUrl()),
                                              fit: BoxFit.cover,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.75),
                                                spreadRadius: 7,
                                                blurRadius: 9,
                                                offset: const Offset(2, 5),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // those texts
                                        Positioned(
                                          top: Dimensions.screenHeight / 3.728,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: Dimensions.screenWidth / 43,
                                            ),
                                            height: Dimensions.screenHeight /
                                                31.067 *
                                                2,
                                            child: ClipRect(
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                  sigmaX: 5,
                                                  sigmaY: 5,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      Dimensions.screenHeight /
                                                          133.143,
                                                    ),
                                                    color: AppColors.deepGold
                                                        .withOpacity(0.1),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: Dimensions
                                                            .screenHeight /
                                                        116.5,
                                                    horizontal:
                                                        Dimensions.screenWidth /
                                                            53.75,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      //name
                                                      Center(
                                                        child: Row(
                                                          children: [
                                                            // firstname
                                                            Text(
                                                              getFirstName(),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: Dimensions
                                                                        .screenHeight /
                                                                    51.778,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            //sized box
                                                            SizedBox(
                                                              width: Dimensions
                                                                      .screenWidth /
                                                                  86,
                                                            ),
                                                            //last name .
                                                            Text(
                                                              '${getLastName()[0]}.',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: Dimensions
                                                                        .screenHeight /
                                                                    51.778,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      // age
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          // age
                                                          Text(
                                                            getAge(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: Dimensions
                                                                      .screenHeight /
                                                                  62.133,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          //sized box
                                                          SizedBox(
                                                            width: Dimensions
                                                                    .screenWidth /
                                                                86,
                                                          ),
                                                          //years old.
                                                          Text(
                                                            'years old',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: Dimensions
                                                                      .screenHeight /
                                                                  62.133,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // icons
                              Positioned(
                                top: Dimensions.screenHeight / 2.33,
                                left: Dimensions.screenWidth / 4.095,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // dislike
                                    GestureDetector(
                                      onTap: () async {
                                        await likeUserController.likeUser(
                                            false,
                                            int.parse(findMatchesController
                                                .data[index]['id']));
                                        increaseIndex();
                                      },
                                      child: Container(
                                        height: Dimensions.screenHeight / 18.64,
                                        width: Dimensions.screenWidth / 8.6,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: AppColors.deepGold,
                                          size:
                                              Dimensions.screenHeight / 31.067,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.screenWidth / 21.5,
                                    ),
                                    // like
                                    GestureDetector(
                                      onTap: () async {
                                        await likeUserController.likeUser(
                                            true,
                                            int.parse(findMatchesController
                                                .data[index]['id']));
                                        increaseIndex();
                                      },
                                      child: Container(
                                        height: Dimensions.screenHeight / 18.64,
                                        width: Dimensions.screenWidth / 8.6,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.deepGold,
                                              AppColors.lighterGold
                                            ],
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.favorite_outline,
                                          color: Colors.white,
                                          size:
                                              Dimensions.screenHeight / 31.067,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.screenWidth / 21.5,
                                    ),
                                    // open profile
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            AppRoutes.getProfileDetailScreen(
                                                findMatchesController
                                                    .data[index]['id']
                                                    .toString()));
                                      },
                                      child: Container(
                                        height: Dimensions.screenHeight / 18.64,
                                        width: Dimensions.screenWidth / 8.6,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Icon(
                                          Icons.person_outline,
                                          color: AppColors.deepGold,
                                          size:
                                              Dimensions.screenHeight / 31.067,
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
                    }),*/
                  if (controller.isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainPurple,
                      ),
                    )
                  else
                    Obx(() {
                      if (findMatchesController.data.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
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
                                'No more Matches',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.screenHeight / 37.28,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (index == findMatchesController.data.length ||
                          findMatchesController.data == []) {
                        // no more matches
                        return Center(
                          child: Column(
                            children: [
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
                                'No more Matches',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.screenHeight / 37.28,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {}
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.screenWidth / 39.3,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: NetworkImage(getImageUrl()),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: Dimensions.screenHeight / 1.9,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: Dimensions.screenWidth / 43,
                                  ),
                                  child: ClipRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 15,
                                        sigmaY: 15,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            Dimensions.screenHeight / 133.143,
                                          ),
                                          color: AppColors.greyLowPurple
                                              .withOpacity(0.25),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical:
                                              Dimensions.screenHeight / 116.5,
                                          horizontal:
                                              Dimensions.screenWidth / 53.75,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //location
                                            Row(
                                              children: [
                                                Container(
                                                  height: Dimensions.screenHeight / 56.8,
                                                  width: Dimensions.screenWidth / 26.2,
                                                  decoration:
                                                      const BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        'assets/images/loc.png',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Dimensions.screenWidth / 78.6,
                                                ),
                                                Text(
                                                  getCountry(),
                                                  style: TextStyle(
                                                      fontSize: Dimensions
                                                              .screenHeight /
                                                          62,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            //name
                                            Center(
                                              child: Row(
                                                children: [
                                                  // firstname
                                                  Text(
                                                    getFirstName(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: Dimensions
                                                              .screenHeight /
                                                          35,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  //sized box
                                                  SizedBox(
                                                    width:
                                                        Dimensions.screenWidth /
                                                            86,
                                                  ),
                                                  //last name .
                                                  Row(
                                                    children: [
                                                      Text(
                                                        ' ${getLastName()[0]}., ',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: Dimensions
                                                                  .screenHeight /
                                                              35,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        getAge(),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: Dimensions
                                                                  .screenHeight /
                                                              35,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // icons
                              Positioned(
                                top: Dimensions.screenHeight / 2.1,
                                left: Dimensions.screenWidth / 1.3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // dislike
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        await likeUserController.likeUser(
                                            false,
                                            int.parse(findMatchesController
                                                .data[index]['id']));
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        increaseIndex();
                                      },
                                      child: Container(
                                        height: Dimensions.screenHeight / 18.64,
                                        width: Dimensions.screenWidth / 8.6,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.greyLowPurple2,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.black,
                                          size:
                                              Dimensions.screenHeight / 31.067,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.screenWidth / 21.5,
                                    ),
                                    // like
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        await likeUserController.likeUser(
                                            true,
                                            int.parse(findMatchesController
                                                .data[index]['id']));
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        increaseIndex();
                                      },
                                      child: Container(
                                        height: Dimensions.screenHeight / 18.64,
                                        width: Dimensions.screenWidth / 8.6,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              AppColors.gradient1,
                                              AppColors.gradient2,
                                            ],
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.favorite_outline,
                                          color: Colors.white,
                                          size:
                                              Dimensions.screenHeight / 31.067,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.screenWidth / 21.5,
                                    ),
                                    // open profile
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            AppRoutes.getProfileDetailScreen(
                                                findMatchesController
                                                    .data[index]['id']
                                                    .toString()));
                                      },
                                      child: Container(
                                        height: Dimensions.screenHeight / 18.64,
                                        width: Dimensions.screenWidth / 8.6,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.greyLowPurple2,
                                        ),
                                        child: Icon(
                                          Icons.person_outline,
                                          color: Colors.black,
                                          size:
                                              Dimensions.screenHeight / 31.067,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  SizedBox(
                    height: Dimensions.screenHeight / 17.04,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
