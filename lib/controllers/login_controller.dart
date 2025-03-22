import 'package:chat_app/Route/app_route.dart';
import 'package:chat_app/services/Firebase_Cloud_messaging_Services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import 'package:toastification/toastification.dart';

class LoginController extends GetxController {
  RxBool isPassword = true.obs;

  // Toggle password visibility
  void changeVisibilityPassword() {
    isPassword.value = !isPassword.value;
  }

  // Handle user login
  Future<void> loginNewUser({
    required String email,
    required String password,
  }) async {
    try {
      var msg = await AuthService.instance.login(
        userEmail: email,
        userPassword: password,
      );

      if (msg == "Success") {
        Get.offNamed(AppRoute.homepage); // Navigate to home screen

        showToastMessage(
          title: "Success",
          description: "Login successful! 😎",
          type: ToastificationType.success,
        );
      } else {
        showToastMessage(
          title: "LOGIN FAILED",
          description: msg,
          type: ToastificationType.error,
        );
      }
    } catch (e) {
      showToastMessage(
        title: "Error",
        description: "An error occurred during login. Please try again.",
        type: ToastificationType.error,
      );
    }
  }

  // Handle Google Sign-in
  Future<void> signInWithGoogle() async {
    try {
      String msg = await AuthService.instance.loginWithGoogle();

      if (msg == "Success") {
        Get.offNamed(AppRoute.homepage); // Navigate to home screen

        var user = AuthService.instance.currentUser;

        if (user != null) {
          // Add user to Firestore
          await FireStoreService.fireStoreService.addUser(
            user: UserModel(
              uid: user.uid,
              name: user.displayName ?? "Anonymous", // Default if null
              email: user.email ?? "No Email", // Default if null
              password: "",
              image: user.photoURL ?? "", // Default empty if null
              token: await FirebaseCloudMessagingService.instance
                      .fetchAccessToken() ??
                  "",
            ),
          );
        }

        showToastMessage(
          title: "Success",
          description: "Google login successful! 😎",
          type: ToastificationType.success,
        );
      } else {
        showToastMessage(
          title: "LOGIN FAILED",
          description: msg,
          type: ToastificationType.error,
        );
      }
    } catch (e) {
      showToastMessage(
        title: "Error",
        description: "An error occurred during Google login. Please try again.",
        type: ToastificationType.error,
      );
    }
  }

  // Helper function for showing toast messages
  void showToastMessage({
    required String title,
    required String description,
    required ToastificationType type,
  }) {
    toastification.show(
      title: Text(title),
      description: Text(description),
      autoCloseDuration: const Duration(seconds: 3),
      type: type,
      style: ToastificationStyle.minimal,
    );
  }
}
