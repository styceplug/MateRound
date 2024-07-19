import 'package:flutter/material.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';

class MessageTextField extends StatefulWidget {
  final Function(String) onMessageSent;
  final TextEditingController textController;

  const MessageTextField({
    Key? key,
    required this.onMessageSent,
    required this.textController,
  }) : super(key: key);

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.screenHeight / 116.5,
          horizontal: Dimensions.screenWidth / 53.75,
        ),
        child: TextField(
          controller: widget.textController,
          onSubmitted: (text) {
            widget.onMessageSent(text);
            widget.textController.clear();
          },
          textAlignVertical: TextAlignVertical.center,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.send,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: Dimensions.screenHeight / 116.5,
              horizontal: Dimensions.screenWidth / 26.875,
            ),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(Dimensions.screenHeight / 93.2),
            ),
            hintText: 'Send a message',
            filled: true,
            fillColor: AppColors.greyLowPurple,
          ),
        ),
      ),
    );
  }
}
