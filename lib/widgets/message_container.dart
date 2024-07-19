import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mate_round/routes/routes.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';

class MessageContainer extends StatelessWidget {
  final String id;
  final int index;
  final String name;
  final String lastText;
  final String image;

  const MessageContainer({
    super.key,
    required this.name,
    required this.lastText,
    required this.image,
    required this.id,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {

    void openMessage (String id, int index){
      Get.offNamed(AppRoutes.getChatScreen(id, name, image, 0));
    }

    return GestureDetector(
      onTap:() => openMessage(id,index),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Dimensions.screenWidth / 43,
          vertical: Dimensions.screenHeight / 466,
        ),
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.screenHeight / 186.4,
          horizontal: Dimensions.screenWidth / 43,
        ),
        height: Dimensions.screenHeight / 12.427,
        width: double.maxFinite,
        child: Row(
          children: [
            Container(
              height: Dimensions.screenHeight / 18.64,
              width: Dimensions.screenWidth / 8.6,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lilacPurple,
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.contain,
                  )),
            ),
            Container(
              width: Dimensions.screenWidth / 1.323,
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.screenWidth / 43,
                vertical: Dimensions.screenHeight / 186.4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight / 186.4,
                  ),
                  Text(
                    lastText,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
