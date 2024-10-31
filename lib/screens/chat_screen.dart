import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mate_round/controllers/conversations_controller.dart';
import 'package:mate_round/routes/routes.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';
import 'package:mate_round/widgets/message_bubble.dart';
import 'package:mate_round/widgets/message_text_field.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String name;
  final String image;
  final int from;

  const ChatScreen({
    super.key,
    required this.userId,
    required this.name,
    required this.image,
    required this.from,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ConversationsController conversationsController =
      Get.put(ConversationsController());
  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    updateMessages();
  }

  void updateMessages() async {
    await conversationsController.fetchData();
  }

  @override
  void initState() {
    super.initState();
    conversationsController.fetchConversation(int.parse(widget.userId));
  }

  Future<void> sendMessage(String text) async {
    try {
      await conversationsController.sendMessage(int.parse(widget.userId), text);
      conversationsController.fetchConversation(int.parse(widget.userId));
      textController.clear();
    } catch (e) {
      print('Failed to send message: $e');
    }
  }

  String convertDate(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);

    String outputDate = DateFormat('MMM dd, hh:mm a').format(dateTime);

    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (widget.from == 1) {
              Get.offNamed(AppRoutes.getProfileDetailScreen(widget.userId));
            } else {
              Get.offNamed(AppRoutes.getMessagesScreen());
            }
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          widget.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.call),
          // ),
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.getVideoCallScreen());
            },
            icon: const Icon(Icons.video_camera_front),
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.getProfileDetailScreen(widget.userId));
            },
            icon: const Icon(Icons.person),
          ),
        ],
        backgroundColor: AppColors.text,
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.image,),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.75),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (conversationsController.conversation.isEmpty) {
                    return Center(
                      child: Text(
                        'No messages yet',
                        style: TextStyle(
                          fontSize: Dimensions.screenHeight / 93.2 * 2 * 1.15,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    );
                  } else {
                    return ListView.separated(
                      padding: EdgeInsets.only(
                        bottom: Dimensions.screenHeight / 58.25,
                      ),
                      reverse: true,
                      itemCount: conversationsController.conversation.length,
                      itemBuilder: (_, index) => MessageBubble(
                        message: conversationsController.conversation[index]
                            ['text'],
                        date: convertDate(conversationsController
                            .conversation[index]['created_at']),
                        profileImageUrl: conversationsController
                                    .conversation[index]['fromMe'] ==
                                0
                            ? widget.image
                            : null,
                      ),
                      separatorBuilder: (_, __) => SizedBox(
                        height: Dimensions.screenHeight / 58.25,
                      ),
                    );
                  }
                }),
              ),
              MessageTextField(
                onMessageSent: sendMessage,
                textController: textController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
