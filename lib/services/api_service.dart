import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/services.dart';

class ImageUploadService {
  ImageUploadService._();

  static final ImageUploadService instance = ImageUploadService._();

  Future<String> uploadImage({required File imageFile}) async {
    final Uri apiUrl = Uri.parse("https://api.imgur.com/3/image");

    final Uint8List imageBytes = await imageFile.readAsBytes();
    final String encodedImage = base64Encode(imageBytes);

    String imageUrl =
        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.etsy.com%2Fmarket%2Fgirl_profile_picture&psig=AOvVaw0PJ5XAPUFM7wuaBdEJwo_A&ust=1742540242053000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCIj8z7aKmIwDFQAAAAAdAAAAABAE";

    try {
      final http.Response response = await http.post(
        apiUrl,
        headers: {
          'Authorization': "Client-ID 0740619ff61eff4",
        },
        body: encodedImage,
      );

      log("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        log("Image URL: ${responseData['data']['link']}");
        imageUrl = responseData['data']['link'];
      }
    } catch (e) {
      log("Error: $e");
    }

    return imageUrl;
  }
}
