import 'package:get/get.dart';

import '../services/auth_service.dart';

class HomeController extends GetxController {
  Future<void> signOut() async {
    await AuthService.instance.signOut();
  }
}
