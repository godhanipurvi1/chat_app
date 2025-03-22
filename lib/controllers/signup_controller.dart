import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

import '../model/user_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class RegisterController extends GetxController {
  RxBool isPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;

  File? image;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  // Register new user
  Future<void> registerNewUser({
    required String userName,
    required String email,
    required String password,
    required String image,
  }) async {
    String msg = await AuthService.instance.register(
      userEmail: email,
      userPassword: password,
    );

    if (msg == 'Success') {
      Get.back();

      FireStoreService.fireStoreService.addUser(
        user: UserModel(
          uid: AuthService.instance.currentUser?.uid ?? "",
          name: userName,
          email: email,
          password: password,
          image: image,
          token: await FirebaseMessaging.instance.getToken() ?? "",
        ),
      );

      // Show success toast
      toastification.show(
        title: const Text("Success"),
        description: const Text(
          "Registration successful! ",
        ),
        autoCloseDuration: const Duration(seconds: 3),
        type: ToastificationType.success,
        style: ToastificationStyle.minimal,
      );
    } else {
      // Show error toast if registration fails
      toastification.show(
        title: const Text("Registration Failed"),
        description: Text(msg),
        autoCloseDuration: const Duration(seconds: 3),
        type: ToastificationType.error,
        style: ToastificationStyle.minimal,
      );
    }
  }

  // Pick user image using camera
  Future<void> pickUserImage() async {
    ImagePicker picker = ImagePicker();

    try {
      XFile? xFile = await picker.pickImage(source: ImageSource.camera);

      if (xFile != null) {
        image = File(xFile.path);
      }

      update(); // Update the UI after image selection
    } catch (e) {
      // If there is an error while picking the image, show a toast
      toastification.show(
        title: const Text("Error"),
        description: const Text("Failed to pick an image"),
        autoCloseDuration: const Duration(seconds: 3),
        type: ToastificationType.error,
        style: ToastificationStyle.minimal,
      );
    }
  }
}
