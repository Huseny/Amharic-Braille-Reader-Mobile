import 'dart:convert';
import 'dart:io';
import 'package:amharic_braille/application/models/translation_model.dart';
import 'package:amharic_braille/repository/local_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BrailleRepository {
  final String _url = 'http://192.168.43.108:8000';
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<List<TranslationModel>> getRecents() async {
    try {
      final List<TranslationModel> recents = [];
      List<TranslationModel> dataList = await dbHelper.getAllTranslations();
      recents.addAll(dataList);
      return recents;
    } catch (e) {
      debugPrint('Exception: $e');
      rethrow;
    }
  }

  Future<TranslationModel> translateBraille(File image) async {
    final request =
        http.MultipartRequest('POST', Uri.parse("$_url/upload_image/"))
          ..files.add(await http.MultipartFile.fromPath('image', image.path));

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = (await http.Response.fromStream(response)).body;
        final jsonResponse = json.decode(responseBody);
        final Map<String, dynamic> jsonFinal = {
          "id": jsonResponse["id"],
          "image": await image.readAsBytes(),
          "braille": (jsonResponse["braille"] as List).join("\n"),
          "translation": (jsonResponse["translation"] as List).join("\n"),
          "createdAt": DateTime.now().toIso8601String()
        };

        final TranslationModel translation =
            TranslationModel.fromJson(jsonFinal);
        _storeLocally(translation);
        return translation;
      } else {
        debugPrint('Error: ${response.reasonPhrase}');
        throw HttpException(response.reasonPhrase ?? "Error");
      }
    } catch (e) {
      debugPrint('Exception: $e');
      rethrow;
    }
  }

  Future<int> _storeLocally(TranslationModel translationModel) async {
    int id = await dbHelper.insertTranslation(translationModel);

    debugPrint('Translated data saved to database with id: $id');
    return id;
  }
}
