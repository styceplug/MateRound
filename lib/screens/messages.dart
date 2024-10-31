import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate_round/controllers/conversations_controller.dart';
import 'package:mate_round/routes/routes.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';
import 'package:mate_round/widgets/build_circle.dart';
import 'package:mate_round/widgets/message_container.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> with WidgetsBindingObserver {
  final ConversationsController conversationsController =
      Get.put(ConversationsController());

  @override
  void initState() {
    super.initState();
    conversationsController.fetchData();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      conversationsController.fetchData();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  final String dummyImage =
      'https://materound.com/auth/upload/photos/2023/10/67_65293fa8135a5_image_picker_59808DF5-FD45-4645-A552-17B7F28BFACB-49978-00000973B0572E91.jpg';

  final String dummyFirstName = "Bishop";

  final String dummyLastName = "Olumayor";

  final int dummyAge = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ConversationsController>(
        builder: (ConversationsController controller) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                height: Dimensions.screenHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //top space
                    Container(
                      height: Dimensions.screenHeight / 9.32,
                    ),
                    //messages and menu
                    Container(
                      margin: EdgeInsets.only(
                        left: Dimensions.screenWidth / 21.5,
                        right: Dimensions.screenWidth / 21.5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //find match
                          Text(
                            'Messages',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.screenHeight / 31.067,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          //four dots
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.getMenuScreen());
                            },
                            child: Container(
                              color: Colors.transparent,
                              height: Dimensions.screenHeight / 31.067,
                              width: Dimensions.screenWidth / 14.333,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const BuildCircle(),
                                      SizedBox(
                                        width: Dimensions.screenWidth / 71.667,
                                      ),
                                      const BuildCircle(),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.screenHeight / 155.333,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const BuildCircle(),
                                      SizedBox(
                                        width: Dimensions.screenWidth / 71.667,
                                      ),
                                      const BuildCircle(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight / 37.28,
                    ),
                    //grey line
                    Container(
                      height: Dimensions.screenHeight / 1864,
                      color: Colors.grey[500],
                      margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.screenWidth / 14.33,
                      ),
                    ),
                    if (controller.isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      Obx(() {
                        if (conversationsController.data.isEmpty) {
                          return Center(
                            child: Column(
                              children: [
                                // no messages image
                                Container(
                                  height: Dimensions.screenHeight / 3.389,
                                  width: Dimensions.screenWidth / 1.564,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/empty_icon.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.screenHeight / 93.2 * 2,
                                ),
                                // no messages text
                                Text(
                                  'No Messages yet',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.screenHeight / 37.28,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (conversationsController.data.isEmpty) {
                          // no more matches
                          return Center(
                            child: Column(
                              children: [
                                // no messages image
                                Container(
                                  height: Dimensions.screenHeight / 3.389,
                                  width: Dimensions.screenWidth / 1.564,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/empty_icon.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.screenHeight / 93.2 * 2,
                                ),
                                // no messages text
                                Text(
                                  'No Messages yet',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.screenHeight / 37.28,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: conversationsController.data.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    MessageContainer(
                                      name:
                                          '${conversationsController.data[index]['userDetails']['first_name']} ${conversationsController.data[index]['userDetails']['last_name']}',
                                      lastText: conversationsController
                                                  .data[index]['fromMe'] ==
                                              1
                                          ? 'you: ${conversationsController.data[index]['latestMessage']}'
                                          : conversationsController.data[index]
                                              ['latestMessage'],
                                      image:
                                          'https://materound.com/auth/${conversationsController.data[index]['userDetails']['avater']}',
                                      id: conversationsController.data[index]
                                              ['partnerUserID']
                                          .toString(),
                                      index: index,
                                    ),
                                    Container(
                                      height: Dimensions.screenHeight / 1864,
                                      color: Colors.grey[500],
                                      margin: EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.screenWidth / 14.33,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        }
                      }),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
