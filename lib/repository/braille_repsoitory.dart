import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BrailleRepository {
  final String _url = 'https://braille-yodg.onrender.com';

  Future<List> getRecents() async {
    try {
      return [];
    } catch (e) {
      debugPrint('Exception: $e');
      rethrow;
    }
  }

  Future<List<String>> translateBraille(String imagePath) async {
    final request =
        http.MultipartRequest('POST', Uri.parse("$_url/upload_image/"))
          ..files.add(await http.MultipartFile.fromPath('image', imagePath));

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        var responseBody =
            await jsonDecode(await response.stream.bytesToString());
        debugPrint('Response: $responseBody');
        return responseBody['translation'].cast<String>();
      } else {
        debugPrint('Error: ${response.reasonPhrase}');
        throw HttpException(response.reasonPhrase ?? "Error");
      }
    } catch (e) {
      debugPrint('Exception: $e');
      rethrow;
    }
  }
}
