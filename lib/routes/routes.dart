import 'package:get/get.dart';
import 'package:mate_round/screens/chat_screen.dart';
import 'package:mate_round/screens/complete_profile.dart';
import 'package:mate_round/screens/create_account.dart';
import 'package:mate_round/screens/disliked_people.dart';
import 'package:mate_round/screens/dummy_splah.dart';
import 'package:mate_round/screens/expectations.dart';
import 'package:mate_round/screens/forgot_password_screen.dart';
import 'package:mate_round/screens/get_premium.dart';
import 'package:mate_round/screens/home_screen.dart';
import 'package:mate_round/screens/join_now.dart';
import 'package:mate_round/screens/liked_me.dart';
import 'package:mate_round/screens/liked_people.dart';
import 'package:mate_round/screens/login.dart';
import 'package:mate_round/screens/menu_screen.dart';
import 'package:mate_round/screens/messages.dart';
import 'package:mate_round/screens/my_profile.dart';
import 'package:mate_round/screens/profile_detail.dart';
import 'package:mate_round/screens/splash_screen.dart';
import 'package:mate_round/screens/video_call_screen.dart';
import 'package:mate_round/screens/visitors.dart';
import 'package:mate_round/screens/welcome.dart';

class AppRoutes {
  static const String splashScreen = '/splash-screen';
  static const String joinNow = '/join-now';
  static const String createAccount = '/create-account';
  static const String login = '/login';
  static const String completeProfile = '/complete-profile';
  static const String expectations = '/expectations';
  static const String homeScreen = '/home-screen';
  static const String menuScreen = '/menu-screen';
  static const String messages = '/messages';
  static const String profileDetail = '/profile-detail';
  static const String chatScreen = '/chat-screen';
  static const String videoCallScreen = '/video-call-screen';
  static const String myProfileScreen = '/my-profile-screen';
  static const String visitors = '/visitors';
  static const String likedMe = '/liked-me';
  static const String likes = '/likes';
  static const String dislikes = '/disliked';
  static const String premium = '/get-premium';
  static const String dummySplash = '/dummy-splash';
  static const String forgotPassword = '/forgot-password';

  static String getSplashScreen() => '$splashScreen';

  static String getJoinNow() => '$joinNow';

  static String getCreateAccount() => '$createAccount';

  static String getLogin() => '$login';

  static String getCompleteProfile() => '$completeProfile';

  static String getExpectations() => '$expectations';

  static String getHomeScreen() => '$homeScreen';

  static String getMenuScreen() => '$menuScreen';

  static String getMessagesScreen() => '$messages';

  static String getProfileDetailScreen(String userId) =>
      '$profileDetail?id=$userId';

  static String getChatScreen(
          String userId, String name, String image, int from) =>
      '$chatScreen?id=$userId&name=$name&image=$image&from=$from';

  static String getVideoCallScreen() => '$videoCallScreen';

  static String getMyProfileScreen() => '$myProfileScreen';

  static String getVisitors() => '$visitors';

  static String getLikedMe() => '$likedMe';

  static String getLikes() => '$likes';

  static String getDisLikes() => '$dislikes';

  static String getPremium() => '$premium';

  static String getDummySplash() => '$dummySplash';

  static String getForgotPassword() => '$forgotPassword';

  static final routes = [
    GetPage(
      name: splashScreen,
      page: () {
        return const SplashScreen();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: joinNow,
      page: () {
        return const Welcome();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: createAccount,
      page: () {
        return const CreateAccount();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: login,
      page: () {
        return const Login();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: completeProfile,
      page: () {
        return const CompleteProfile();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: expectations,
      page: () {
        return const Expectations();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: homeScreen,
      page: () {
        return const HomeScreen();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: menuScreen,
      page: () {
        return const MenuScreen();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: messages,
      page: () {
        return const Messages();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: profileDetail,
      page: () {
        var userId = Get.parameters['id'];
        return ProfileDetail(
          userId: userId!,
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: chatScreen,
      page: () {
        var userId = Get.parameters['id'];
        var name = Get.parameters['name'];
        var image = Get.parameters['image'];
        var from = Get.parameters['from'];
        return ChatScreen(
          userId: userId!,
          name: name!,
          image: image!,
          from: int.parse(from!),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: videoCallScreen,
      page: () {
        return const VideoCallScreen();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: myProfileScreen,
      page: () {
        return const MyProfile();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: visitors,
      page: () {
        return const Visitors();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: likedMe,
      page: () {
        return const LikedMe();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: likes,
      page: () {
        return const LikedPeople();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: dislikes,
      page: () {
        return const DislikedPeople();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: premium,
      page: () {
        return const GetPremium();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: dummySplash,
      page: () {
        return const DummySplash();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: forgotPassword,
      page: () {
        return const ForgotPassword();
      },
      transition: Transition.fadeIn,
    ),
  ];
}
