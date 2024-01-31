import 'dart:convert';
import 'dart:io';
import 'package:amharic_braille/application/models/translation_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BrailleRepository {
  final String _url = 'http://192.168.43.108:8000';

  Future<List<TranslationModel>> getRecents() async {
    try {
      return [];
    } catch (e) {
      debugPrint('Exception: $e');
      rethrow;
    }
  }

  Future<TranslationModel> translateBraille(String imagePath) async {
    final request =
        http.MultipartRequest('POST', Uri.parse("$_url/upload_image/"))
          ..files.add(await http.MultipartFile.fromPath('image', imagePath));

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = (await http.Response.fromStream(response)).body;
        final jsonResponse = json.decode(responseBody);
        return TranslationModel.fromJson(jsonResponse as Map<String, dynamic>);
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
