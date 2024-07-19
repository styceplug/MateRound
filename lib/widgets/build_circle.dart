import 'package:flutter/material.dart';
import 'package:mate_round/utils/dimensions.dart';

class BuildCircle extends StatelessWidget {
  const BuildCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.screenWidth / 71.667,
      height: Dimensions.screenHeight / 155.333,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
    );
  }
}
