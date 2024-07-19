import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';
import 'package:mate_round/routes/routes.dart';

class GetPremium extends StatefulWidget {
  const GetPremium({super.key});

  @override
  State<GetPremium> createState() => _GetPremiumState();
}

class _GetPremiumState extends State<GetPremium> {
  late int userId;

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId') ?? -1;
  }

  Future<void> setPro() async {
    Uri url = Uri.parse('https://materound.com/app/api/v1/profile/set_pro.php');
    try {
      var response = await http.post(
        url,
        body: {
          'user_id': userId.toString(),
          'pro_type': proType.toString(),
        },
      );

      if (response.statusCode == 200) {
        var responseBody = response.body;
        print("onSuccess: $responseBody");
        Get.snackbar('Success', responseBody);
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setInt('isPro', 1);
        await prefs.setInt('proType', proType);
      } else {
        print(
            "Error occurred while trying to set pro. Status code: ${response.statusCode}");
        Get.snackbar('Error',
            "Error occurred while trying to set pro. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Failed to make the POST request: $e");
      Get.snackbar('Error', "Failed to make the request: $e");
    }
  }

  String chosenPlan = 'monthly';
  int chosenPrice = 25;
  int weeklyPrice = 8;
  int monthlyPrice = 25;
  int yearlyPrice = 280;
  int lifetimePrice = 500;
  int proType = 2;

  void setChosenPlan(String plan) {
    int newPrice;
    int newProType;

    switch (plan) {
      case 'weekly':
        newPrice = 8;
        newProType = 1;
        break;
      case 'monthly':
        newPrice = 25;
        newProType = 2;
        break;
      case 'yearly':
        newPrice = 280;
        newProType = 3;
        break;
      case 'lifetime':
        newPrice = 500;
        newProType = 4;
        break;
      default:
        newPrice = 25;
        newProType = 2;
        break;
    }

    setState(() {
      chosenPlan = plan;
      chosenPrice = newPrice;
      proType = newProType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.ppWhite,
            ),
          ),
          Container(
            height: Dimensions.screenHeight,
            width: Dimensions.screenWidth,
            color: AppColors.greyDarkPurple,
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.screenHeight / 9.32 / 1.25,
                ),
                // get Premium
                Text(
                  'Get Premium',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.screenHeight / 93.2 * 2,
                  ),
                ),
                // sized box
                SizedBox(
                  height: Dimensions.screenHeight / 9.32 / 50,
                ),
                // screen content
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // top text
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.screenWidth / 21.5,
                            vertical: Dimensions.screenHeight / 46.6,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.screenWidth / 17.2,
                            vertical: Dimensions.screenHeight / 37.28,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(
                              Dimensions.screenHeight / 93.2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Amazing Materound features you can’t live without.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.screenHeight / 42.364,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.screenHeight / 46.6,
                              ),
                              Text(
                                'Activating Premium will help you meet more people, faster.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.screenHeight / 51.778,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //sized box
                        SizedBox(
                          height: Dimensions.screenHeight / 46.6,
                        ),
                        //weekly
                        GestureDetector(
                          onTap: () {
                            setChosenPlan('weekly');
                          },
                          child: Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(
                              horizontal: Dimensions.screenWidth / 21.5,
                              vertical: Dimensions.screenHeight / 46.6,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.screenWidth / 17.2,
                              vertical: Dimensions.screenHeight / 37.28,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(
                                Dimensions.screenHeight / 93.2,
                              ),
                              border: Border.all(
                                width: chosenPlan == 'weekly' ? 3 : 1.5,
                                color: chosenPlan == 'weekly'
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            // the diamond image and text
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/weekly.svg',
                                                  fit: BoxFit.cover,
                                                ),
                                                SizedBox(
                                                  width:
                                                      Dimensions.screenWidth /
                                                          43,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    const Text(
                                                      'Weekly',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Dimensions
                                                              .screenHeight /
                                                          186.4,
                                                    ),
                                                    const Text(
                                                      'package',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            //sized box
                                            SizedBox(
                                              height: Dimensions.screenHeight /
                                                  93.2,
                                            ),
                                            // price
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '\$',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: Dimensions
                                                            .screenHeight /
                                                        46.6,
                                                  ),
                                                ),
                                                Text(
                                                  weeklyPrice.toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: Dimensions
                                                            .screenHeight /
                                                        46.6,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            //sized box
                                            SizedBox(
                                              height: Dimensions.screenHeight /
                                                  93.2,
                                            ),
                                            // grey line
                                            Container(
                                              height: 1,
                                              color: Colors.grey,
                                            ),
                                            //sized box
                                            SizedBox(
                                              height: Dimensions.screenHeight /
                                                  93.2,
                                            ),
                                            const Column(
                                              children: [
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Get more stickers in chat',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Show yourself in premium bar',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'View likes notifications',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Get a discount when using "boost me"',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Display first in find matches',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Display on top in random users',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Create unlimited video and audio calls.',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Find potential matches by country',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        //sized box
                        SizedBox(
                          height: Dimensions.screenHeight / 46.6,
                        ),
                        //monthly
                        GestureDetector(
                          onTap: () {
                            setChosenPlan('monthly');
                          },
                          child: Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(
                              horizontal: Dimensions.screenWidth / 21.5,
                              vertical: Dimensions.screenHeight / 46.6,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.screenWidth / 17.2,
                              vertical: Dimensions.screenHeight / 37.28,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(
                                Dimensions.screenHeight / 93.2,
                              ),
                              border: Border.all(
                                width: chosenPlan == 'monthly' ? 3 : 1.5,
                                color: chosenPlan == 'monthly'
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            // the diamond image and text
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/monthly.svg',
                                                  fit: BoxFit.cover,
                                                ),
                                                SizedBox(
                                                  width:
                                                      Dimensions.screenWidth /
                                                          43,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    const Text(
                                                      'Monthly',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Dimensions
                                                              .screenHeight /
                                                          186.4,
                                                    ),
                                                    const Text(
                                                      'package',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            //sized box
                                            SizedBox(
                                              height: Dimensions.screenHeight /
                                                  93.2,
                                            ),
                                            // price
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '\$',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: Dimensions
                                                            .screenHeight /
                                                        46.6,
                                                  ),
                                                ),
                                                Text(
                                                  monthlyPrice.toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: Dimensions
                                                            .screenHeight /
                                                        46.6,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            //sized box
                                            SizedBox(
                                              height: Dimensions.screenHeight /
                                                  93.2,
                                            ),
                                            // grey line
                                            Container(
                                              height: 1,
                                              color: Colors.grey,
                                            ),
                                            //sized box
                                            SizedBox(
                                              height: Dimensions.screenHeight /
                                                  93.2,
                                            ),
                                            const Column(
                                              children: [
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Get more stickers in chat',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Show yourself in premium bar',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'View likes notifications',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Get a discount when using "boost me"',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Display first in find matches',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Display on top in random users',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Create unlimited video and audio calls.',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Find potential matches by country',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        //sized box
                        SizedBox(
                          height: Dimensions.screenHeight / 46.6,
                        ),
                        //yearly
                        GestureDetector(
                          onTap: () {
                            setChosenPlan('yearly');
                          },
                          child: Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(
                              horizontal: Dimensions.screenWidth / 21.5,
                              vertical: Dimensions.screenHeight / 46.6,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.screenWidth / 17.2,
                              vertical: Dimensions.screenHeight / 37.28,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(
                                Dimensions.screenHeight / 93.2,
                              ),
                              border: Border.all(
                                width: chosenPlan == 'yearly' ? 3 : 1.5,
                                color: chosenPlan == 'yearly'
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            // the diamond image and text
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/yearly.svg',
                                                  fit: BoxFit.cover,
                                                ),
                                                SizedBox(
                                                  width:
                                                      Dimensions.screenWidth /
                                                          43,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    const Text(
                                                      'Yearly',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Dimensions
                                                              .screenHeight /
                                                          186.4,
                                                    ),
                                                    const Text(
                                                      'package',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            //sized box
                                            SizedBox(
                                              height: Dimensions.screenHeight /
                                                  93.2,
                                            ),
                                            // price
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '\$',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: Dimensions
                                                            .screenHeight /
                                                        46.6,
                                                  ),
                                                ),
                                                Text(
                                                  yearlyPrice.toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: Dimensions
                                                            .screenHeight /
                                                        46.6,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            //sized box
                                            SizedBox(
                                              height: Dimensions.screenHeight /
                                                  93.2,
                                            ),
                                            // grey line
                                            Container(
                                              height: 1,
                                              color: Colors.grey,
                                            ),
                                            //sized box
                                            SizedBox(
                                              height: Dimensions.screenHeight /
                                                  93.2,
                                            ),
                                            const Column(
                                              children: [
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Get more stickers in chat',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Show yourself in premium bar',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'View likes notifications',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Get a discount when using "boost me"',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Display first in find matches',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Display on top in random users',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Create unlimited video and audio calls.',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Find potential matches by country',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        //sized box
                        SizedBox(
                          height: Dimensions.screenHeight / 46.6,
                        ),
                        //lifetime
                        GestureDetector(
                          onTap: () {
                            setChosenPlan('lifetime');
                          },
                          child: Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(
                              horizontal: Dimensions.screenWidth / 21.5,
                              vertical: Dimensions.screenHeight / 46.6,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.screenWidth / 17.2,
                              vertical: Dimensions.screenHeight / 37.28,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(
                                Dimensions.screenHeight / 93.2,
                              ),
                              border: Border.all(
                                width: chosenPlan == 'lifetime' ? 3 : 1.5,
                                color: chosenPlan == 'lifetime'
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            // the diamond image and text
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/lifetime.svg',
                                                  fit: BoxFit.cover,
                                                ),
                                                SizedBox(
                                                  width:
                                                      Dimensions.screenWidth /
                                                          43,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    const Text(
                                                      'Lifetime',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Dimensions
                                                              .screenHeight /
                                                          186.4,
                                                    ),
                                                    const Text(
                                                      'package',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            //sized box
                                            SizedBox(
                                              height: Dimensions.screenHeight /
                                                  93.2,
                                            ),
                                            // price
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '\$',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: Dimensions
                                                            .screenHeight /
                                                        46.6,
                                                  ),
                                                ),
                                                Text(
                                                  lifetimePrice.toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: Dimensions
                                                            .screenHeight /
                                                        46.6,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            //sized box
                                            SizedBox(
                                              height: Dimensions.screenHeight /
                                                  93.2,
                                            ),
                                            // grey line
                                            Container(
                                              height: 1,
                                              color: Colors.grey,
                                            ),
                                            //sized box
                                            SizedBox(
                                              height: Dimensions.screenHeight /
                                                  93.2,
                                            ),
                                            const Column(
                                              children: [
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Get more stickers in chat',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Show yourself in premium bar',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'View likes notifications',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Get a discount when using "boost me"',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Display first in find matches',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Display on top in random users',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Create unlimited video and audio calls.',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(
                                                    'Find potential matches by country',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        //sized box
                        SizedBox(
                          height: Dimensions.screenHeight / 46.6,
                        ),
                        // chosen plan and price
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.screenWidth / 21.5,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.screenWidth / 17.2,
                            vertical: Dimensions.screenHeight / 37.28,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(
                              Dimensions.screenHeight / 93.2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Chosen Plan : ',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.screenWidth / 86,
                                  ),
                                  Text(
                                    '$chosenPlan package',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.screenHeight / 186.4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Plan price : ',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.screenWidth / 86,
                                  ),
                                  Text(
                                    '\$ ${chosenPrice.toString()}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //sized box
                        SizedBox(
                          height: Dimensions.screenHeight / 46.6,
                        ),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Pay Using',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.screenHeight / 46.6,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.screenHeight / 58.25,
                              ),
                              ElevatedButton.icon(
                                icon: SvgPicture.network(
                                  'https://upload.wikimedia.org/wikipedia/commons/b/b5/PayPal.svg',
                                  height: Dimensions.screenHeight / 38.833,
                                  width: 24.0,
                                ),
                                label: const Text(''),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PaypalCheckout(
                                        sandboxMode: true,
                                        clientId:
                                            "AaFq6vhpU6xLlZHXKwv9f5Ifwif34DouInKJanUUiiDX-8xwipBg4CBcmJHIGoIYwyW_Sjv2Wc79hhUI",
                                        secretKey:
                                            "EICln5uscKOScRLmyvryzHMm7h0WvgB7lW0aGEKYVBMnYmSSp52w78pK4Bhz1nOBSAV_WpQXRWZzd_ZJ",
                                        returnURL: "https://materound.com/app/api/v1/profile/set_pro.php?user_id=$userId&pro_type=$proType",
                                        cancelURL: "https://materound.com/app/api/v1/profile/set_pro.php?user_id=0&pro_type=0",
                                        transactions: [
                                          {
                                            "amount": {
                                              "total": chosenPrice.toString(),
                                              "currency": "USD",
                                              "details": {
                                                "subtotal":
                                                    chosenPrice.toString(),
                                                "shipping": '0',
                                                "shipping_discount": 0
                                              }
                                            },
                                            "description":
                                                "The payment transaction description.",
                                            "item_list": {
                                              "items": [
                                                {
                                                  "name": "Materound premium",
                                                  "quantity": 1,
                                                  "price":
                                                      chosenPrice.toString(),
                                                  "currency": "USD"
                                                }
                                              ],
                                            }
                                          }
                                        ],
                                        note:
                                            "Suscribing to Materound premium $chosenPlan plan",
                                        onSuccess: (Map params) async {
                                          setPro();
                                          print("onSuccess: $params");
                                        },
                                        onError: (error) {
                                          print("onError: $error");
                                          Navigator.pop(context);
                                        },
                                        onCancel: () {
                                          Get.offNamed(
                                              AppRoutes.getPremium());
                                          print('cancelled:');
                                        },
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.blue,
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 32.0,
                                    vertical:
                                        Dimensions.screenHeight / 77.667,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // sized box
                        SizedBox(
                          height: Dimensions.screenHeight / 46.6,
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
