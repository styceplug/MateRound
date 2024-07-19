import 'package:flutter/material.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';

class MessageBubble extends StatelessWidget {
  final String? profileImageUrl;
  final String message;
  final String date;

  const MessageBubble({
    super.key,
    this.profileImageUrl,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final isReceiver = profileImageUrl != null;
    return Row(
      mainAxisAlignment:
          isReceiver ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isReceiver)
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.screenHeight / 116.5,
              horizontal: Dimensions.screenWidth / 53.75,
            ),
            child: CircleAvatar(
              backgroundColor: AppColors.greyPurple,
              foregroundImage: NetworkImage(profileImageUrl!),
            ),
          ),
        Flexible(
          child: Column(
            crossAxisAlignment:
                isReceiver ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.screenWidth / 35.833,
                  vertical: Dimensions.screenHeight / 77.667,
                ),
                constraints:
                    BoxConstraints(maxWidth: Dimensions.screenWidth / 1.564),
                decoration: BoxDecoration(
                  color:
                      isReceiver ? AppColors.greyPurple : AppColors.lilacPurple,
                  borderRadius:
                      BorderRadius.circular(Dimensions.screenHeight / 93.2),
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    color: isReceiver ? Colors.black : Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.screenHeight / 116.5,
              ),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.greyLowPurple,
                ),
              ),
            ],
          ),
        ),
        if (!isReceiver)
          SizedBox(
            width: Dimensions.screenWidth / 35.833,
          ),
      ],
    );
  }
}
