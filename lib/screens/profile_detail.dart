import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate_round/controllers/get_user_controller.dart';
import 'package:mate_round/controllers/like_user_controller.dart';
import 'package:mate_round/routes/routes.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';
import 'package:mate_round/widgets/build_circle.dart';

class ProfileDetail extends StatefulWidget {
  final String userId;

  const ProfileDetail({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  late final GetUserController getUserController;
  final LikeUserController likeUserController = Get.put(LikeUserController());
  bool isLiked = false;
  bool isDisLiked = false;
  bool isFriendSent = false;

  @override
  void initState() {
    super.initState();
    getUserController = GetUserController(userId: int.parse(widget.userId));
    getUserController.fetchData(int.parse(widget.userId));
  }

  void showReportDialog() {
    Get.defaultDialog(
      title: 'Report this user',
      content: const Text('Do you really want to report this user?'),
      textConfirm: 'Yes',
      textCancel: 'Cancel',
      onConfirm: () {
        Get.back();
        showReportSnackbar();
      },
      onCancel: () {
        // Get.back();
      },
      buttonColor: AppColors.primaryColor,
      cancelTextColor: AppColors.primaryColor,
      confirmTextColor: Colors.white,
    );
  }

  void showReportSnackbar() {
    Get.snackbar(
      'User Reported',
      'You have successfully reported this user',
    );
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
      return "50"; // Handle invalid date format
    }
  }

  String getGenderString(String input) {
    switch (input) {
      case '4526':
        return 'female';
      case '4525':
        return 'male';
      case '0':
        return 'Custom';
      case 'male':
        return 'male';
      case 'female':
        return 'female';
      default:
        return 'Unknown';
    }
  }

  String formatHeight(String input) {
    if (input.contains("'")) {
      return input;
    } else if (int.tryParse(input) != null) {
      int heightInCm = int.parse(input);
      return '$heightInCm cm';
    } else {
      return 'Unknown';
    }
  }

  String getHairColor(dynamic input) {
    if (input is String) {
      int intValue;
      try {
        intValue = int.parse(input);
        return getHairColor(intValue);
      } catch (e) {
        return input;
      }
    } else if (input is int) {
      switch (input) {
        case 1:
          return 'Brown';
        case 2:
          return 'Black';
        case 3:
          return 'White';
        case 4:
          return 'Sandy';
        case 5:
          return 'Grey';
        case 6:
          return 'Red/Auburn';
        case 7:
          return 'Blonde';
        case 8:
          return 'Blue';
        case 9:
          return 'Green';
        case 10:
          return 'Orange';
        case 11:
          return 'Pink';
        case 12:
          return 'Purple';
        case 13:
          return 'Bald';
        case 14:
          return 'Others';
        default:
          return 'Unknown';
      }
    } else {
      return 'Unknown';
    }
  }

  final String popularity = 'low';

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
          SizedBox(
            height: Dimensions.screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //top space
                Container(
                  height: Dimensions.screenHeight / 9.32,
                ),
                //name and menu
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.screenWidth / 21.5,
                    right: Dimensions.screenWidth / 21.5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //name
                      Obx(() {
                        if (getUserController.data.isEmpty) {
                          return const CircularProgressIndicator();
                        } else {
                          return Expanded(
                            child: Text(
                              '${getUserController.data['first_name']} ${getUserController.data['last_name']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.screenHeight / 31.067,
                                fontFamily: 'Poppins',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }
                      }),
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
                SizedBox(
                  height: Dimensions.screenHeight / 37.28,
                ),
                //grey line
                Container(
                  height: Dimensions.screenHeight / 1864,
                  color: Colors.grey[500],
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.screenWidth / 14.33,
                  ),
                ),
                SizedBox(
                  height: Dimensions.screenHeight / 37.28,
                ),
                Obx(() {
                  if (getUserController.data.isEmpty) {
                    return const CircularProgressIndicator();
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // image container
                          Container(
                            height: Dimensions.screenHeight / 5.648,
                            width: Dimensions.screenWidth / 2.606,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: Dimensions.screenWidth / 86,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                height: Dimensions.screenHeight / 6.213,
                                width: Dimensions.screenWidth / 2.867,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://materound.com/auth/${getUserController.data['avater']}',
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.screenHeight / 93.2,
                          ),
                          // those icons
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.screenWidth / 8.6,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Dimensions.screenHeight / 93.2,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.screenHeight / 93.2 * 4),
                                  border: Border.all(
                                    width: Dimensions.screenWidth / 430 / 2,
                                    color: AppColors.primaryColor,
                                  )),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await likeUserController.likeUser(
                                          false, int.parse(widget.userId));
                                      setState(() {
                                        isLiked = false;
                                        isDisLiked = true;
                                      });
                                    },
                                    child: Container(
                                      height: Dimensions.screenHeight /
                                          18.64 /
                                          1.25,
                                      width:
                                          Dimensions.screenWidth / 8.6 / 1.25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 2,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      child: Icon(
                                        isDisLiked
                                            ? Icons.heart_broken
                                            : Icons.close,
                                        color: AppColors.primaryColor,
                                        size: Dimensions.screenHeight /
                                            31.067 /
                                            1.25,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.screenWidth / 21.5 / 1.5,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await likeUserController.likeUser(
                                          true, int.parse(widget.userId));
                                      setState(() {
                                        isDisLiked = false;
                                        isLiked = true;
                                      });
                                    },
                                    child: Container(
                                      height: Dimensions.screenHeight /
                                          18.64 /
                                          1.25,
                                      width:
                                          Dimensions.screenWidth / 8.6 / 1.25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 2,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      child: Icon(
                                        isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_outline,
                                        color: AppColors.primaryColor,
                                        size: Dimensions.screenHeight /
                                            31.067 /
                                            1.25,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.screenWidth / 21.5 / 1.5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isFriendSent = !isFriendSent;
                                      });
                                      Get.snackbar(
                                          'Friend Request',
                                          isFriendSent
                                              ? 'Friend Request sent'
                                              : 'Friend Request Retracted');
                                    },
                                    child: Container(
                                      height: Dimensions.screenHeight /
                                          18.64 /
                                          1.25,
                                      width:
                                          Dimensions.screenWidth / 8.6 / 1.25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 2,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      child: Icon(
                                        isFriendSent ? Icons.person_remove : Icons.person_add,
                                        color: AppColors.primaryColor,
                                        size: Dimensions.screenHeight /
                                            31.067 /
                                            1.25,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.screenWidth / 21.5 / 1.5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.offNamed(AppRoutes.getChatScreen(widget.userId, '${getUserController.data['first_name']} ${getUserController.data['last_name']}', 'https://materound.com/auth/${getUserController.data['avater']}', 1));
                                    },
                                    child: Container(
                                      height: Dimensions.screenHeight /
                                          18.64 /
                                          1.25,
                                      width:
                                          Dimensions.screenWidth / 8.6 / 1.25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 2,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.message_outlined,
                                        color: AppColors.primaryColor,
                                        size: Dimensions.screenHeight /
                                            31.067 /
                                            1.25,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.screenWidth / 21.5 / 1.5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showReportDialog();
                                    },
                                    child: Container(
                                      height: Dimensions.screenHeight /
                                          18.64 /
                                          1.25,
                                      width:
                                          Dimensions.screenWidth / 8.6 / 1.25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 2,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.warning_amber_outlined,
                                        color: AppColors.primaryColor,
                                        size: Dimensions.screenHeight /
                                            31.067 /
                                            1.25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.screenHeight / 93.2 / 2,
                          ),
                          //details
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.screenWidth / 21.5,
                              vertical: Dimensions.screenHeight / 46.6,
                            ),
                            child: Column(
                              children: [
                                //popularity
                                ProfileItem(
                                  title: 'Popularity',
                                  value: popularity,
                                ),
                                SizedBox(
                                  height: Dimensions.screenHeight / 93.2 / 2,
                                ),
                                // gender
                                ProfileItem(
                                  title: 'Gender',
                                  value: getGenderString(
                                      getUserController.data['gender']),
                                ),
                                SizedBox(
                                  height: Dimensions.screenHeight / 93.2 / 2,
                                ),
                                //age
                                ProfileItem(
                                  title: 'Age',
                                  value: calculateAge(
                                      getUserController.data['birthday']),
                                ),
                                SizedBox(
                                  height: Dimensions.screenHeight / 93.2 / 2,
                                ),
                                //height
                                ProfileItem(
                                  title: 'Height',
                                  value: formatHeight(
                                      getUserController.data['height']),
                                ),
                                SizedBox(
                                  height: Dimensions.screenHeight / 93.2 / 2,
                                ),
                                // hair color
                                ProfileItem(
                                  title: 'Hair Color',
                                  value: getHairColor(
                                      getUserController.data['hair_color']),
                                ),
                                SizedBox(
                                  height: Dimensions.screenHeight / 93.2,
                                ),
                                // about
                                Container(
                                  padding: EdgeInsets.all(
                                    Dimensions.screenHeight / 93.2 / 2,
                                  ),
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.screenHeight / 93.2),
                                    border: Border.all(
                                      width: 0.5,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  //about
                                  child: Text(
                                    getUserController.data['about'],
                                    style: TextStyle(
                                      fontSize:
                                          Dimensions.screenHeight / 51.778,
                                      fontStyle: FontStyle.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String title;
  final String value;

  const ProfileItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$title : ',
          style: TextStyle(
            fontSize: Dimensions.screenHeight / 51.778,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: Dimensions.screenHeight / 51.778,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
