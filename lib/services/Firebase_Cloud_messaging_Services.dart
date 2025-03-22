import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class FirebaseCloudMessagingService {
  FirebaseCloudMessagingService._();

  static FirebaseCloudMessagingService instance = FirebaseCloudMessagingService._();

  Future<String> fetchAccessToken() async {
    String credentialsFilePath = "assets/json/fcm.json";

    String credentialsJson = await rootBundle.loadString(credentialsFilePath);

    var serviceAccountCredentials = ServiceAccountCredentials.fromJson(credentialsJson);

    List<String> requiredScopes = [
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    var accessToken = await clientViaServiceAccount(serviceAccountCredentials, requiredScopes);

    return accessToken.credentials.accessToken.data;
  }

  Future<void> sendNotification({
    required String notificationTitle,
    required String notificationBody,
    required String deviceToken,
  }) async {
    String accessToken = await fetchAccessToken();

    String apiUrl = "https://fcm.googleapis.com/v1/projects/my-chat-app-2e26a/messages:send";

    Map<String, dynamic> notificationPayload = {
      'message': {
        'token': deviceToken,
        'notification': {
          'title': notificationTitle,
          'body': notificationBody,
        },
        'data': {
          'age': '22',
          'school': 'PQR',
        }
      },
    };

    http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(notificationPayload),
    );

    log("Status Code: ${response.statusCode}");
    if (response.statusCode == 200) {
      log("-------------------------------");
      log("Notification sent successfully...");
      log("Response Data: ${response.body}");
      log("-------------------------------");
    } else {
      log("-------------------------------");
      log("Error: ${response.body}");
      log("-------------------------------");
    }
  }
}
