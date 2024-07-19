import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate_round/routes/routes.dart';

class DummySplash extends StatelessWidget {
  const DummySplash({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 2),
          () => Get.offNamed(AppRoutes.getSplashScreen()),
    );
    return const  Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}
