import 'package:flutter/material.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';

class MenuItem extends StatelessWidget {
  final VoidCallback onPressed;
  final String? img;
  final bool? isIcon;
  final IconData? icon;
  final String text;

  const MenuItem({
    super.key,
    required this.onPressed,
    this.img,
    this.isIcon,
    this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: Dimensions.screenHeight / 14.338,
        margin: EdgeInsets.symmetric(
          horizontal: Dimensions.screenWidth / 21.5,
        ),
        child: Row(
          children: [
            // the icon
            Container(
              height: Dimensions.screenHeight / 18.64,
              width: Dimensions.screenWidth / 8.6,
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.screenWidth / 43,
              ),
              decoration: const BoxDecoration(
                color: AppColors.pink2,
                shape: BoxShape.circle,
              ),
              child: isIcon != null && isIcon == true ? Icon(icon!): img != null
                  ? Image.asset(
                img!,
              )
                  : const SizedBox(),
            ),
            SizedBox(
              width: Dimensions.screenWidth / 43,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: Dimensions.screenHeight / 42.364,
              ),
            ),
          ],
        ),
      ),
    );
  }
}