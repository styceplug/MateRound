import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate_round/routes/routes.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // final LocationService locationService = LocationService();
  // final DeviceInfoService deviceInfoService = DeviceInfoService();

  @override
  void initState() {
    super.initState();
    _initializeApp();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 6,
      ),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  Future<void> _initializeApp() async {
    try {
      // final deviceInfo = await deviceInfoService.getDeviceInfo();
      // final country = await locationService.getCurrentCountry();
      // const country = 'Unknown';
      final deviceLocale = ui.window.locale;
      final countryCode = deviceLocale.countryCode ?? 'Unknown';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('deviceInfo', jsonEncode(deviceInfo));
      await prefs.setString('country', countryCode);
      final int? userId = prefs.getInt('userId');
      final bool? remember = prefs.getBool('remember');
      final bool? isProfileComplete = prefs.getBool('isProfileComplete');
      bool? expectationsSet = prefs.getBool('expectationsSet');
      print(userId);
      print(remember);
      print(isProfileComplete);
      print(expectationsSet);

      if (userId != null && remember == true) {
        if (isProfileComplete == true || expectationsSet == true) {
          if (expectationsSet == true) {
            Timer(
              const Duration(seconds: 6),
              () => Get.offNamed(AppRoutes.getHomeScreen()),
            );
          } else {
            Timer(
              const Duration(seconds: 6),
              () => Get.offNamed(AppRoutes.getExpectations()),
            );
          }
        } else {
          Timer(
            const Duration(seconds: 6),
            () => Get.offNamed(AppRoutes.getCompleteProfile()),
          );
        }
      } else {
        Timer(
          const Duration(seconds: 6),
          () => Get.offNamed(AppRoutes.getJoinNow()),
        );
      }
    } catch (e) {
      print("Exception caught: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  const BoxDecoration(
          color: AppColors.primaryColor,
          ),
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Image.asset(
              'assets/images/materound_animation.gif',
              fit: BoxFit.cover,
             width: Dimensions.width100*3,
              height: Dimensions.height100*3,
            ),
          ),
        ),
      ),
    );
  }
}
