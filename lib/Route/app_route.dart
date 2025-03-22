import 'package:chat_app/screens/chat_room_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/signup_screen.dart';
import 'package:get/get.dart';

import '../screens/login_screen.dart';

class AppRoute {
  static String signup = '/signup';
  static String logIn = '/login';
  static String homepage = '/home';
  static String chatroompage = '/chatroom';
  static List<GetPage> pages = [
    GetPage(
      name: signup,
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: logIn,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: homepage,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: chatroompage,
      page: () => ConversationPage(),
    ),
  ];
}
