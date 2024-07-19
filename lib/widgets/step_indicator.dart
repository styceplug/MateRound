import 'package:flutter/material.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;

  const StepIndicator({Key? key, required this.currentStep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: Dimensions.screenHeight / 26.629,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCircle(currentStep > 0),
              _buildLine(currentStep > 1),
              _buildCircle(currentStep > 1),
              _buildLine(currentStep > 2),
              _buildCircle(currentStep > 2),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: Dimensions.screenWidth / 8.6,
          child: _buildLabel("Avatar", currentStep > 0),
        ),
        Positioned(
          top: 0,
          left: Dimensions.screenWidth / 2.15,
          child: _buildLabel("Info", currentStep > 1),
        ),
        Positioned(
          top: 0,
          right: Dimensions.screenWidth / 12.286,
          child: _buildLabel("Verification", currentStep > 2),
        ),
      ],
    );
  }

  Widget _buildCircle(bool isActive) {
    return Container(
      height: Dimensions.screenHeight / 46.6,
      width: Dimensions.screenWidth / 21.5,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? Colors.black : Colors.grey,
          width: Dimensions.screenWidth / 86,
        ),
      ),
    );
  }

  Widget _buildLine(bool isActive) {
    return Container(
      height: Dimensions.screenHeight / 186.4,
      width: Dimensions.screenWidth / 3.583,
      color: isActive ? Colors.black : Colors.grey,
    );
  }

  Widget _buildLabel(String text, bool isActive) {
    return Text(
      text,
      style: TextStyle(
        color: isActive ? Colors.black : Colors.grey,
        fontSize: Dimensions.screenHeight / 62,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
