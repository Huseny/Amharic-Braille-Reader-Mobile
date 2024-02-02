import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:amharic_braille/application/models/translation_model.dart';
import 'package:amharic_braille/repository/local_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class BrailleRepository {
  final String _url = 'http://192.168.43.80:8000';
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
        final imagePath = await _saveImage(image.readAsBytesSync());
        final audioResponse = await http.post(
          Uri.parse("$_url/get_audio/${jsonResponse["id"]}"),
        );
        final audioPath = await _saveAudio(audioResponse.bodyBytes);
        final Map<String, dynamic> finalJson = {
          "id": jsonResponse["id"],
          "image": imagePath,
          "braille": (jsonResponse["braille"] as List).join("\n"),
          "translation": (jsonResponse["translation"] as List).join("\n"),
          "audio": audioPath,
          "createdAt": DateTime.now().toIso8601String()
        };

        final TranslationModel translation =
            TranslationModel.fromJson(finalJson);
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

  Future<String> _saveImage(Uint8List image) async {
    String path =
        join(await dbHelper.getPath, 'brailles', "${DateTime.now()}.jpg");
    File fileDef = File(path);
    await fileDef.create(recursive: true);
    File img = await fileDef.writeAsBytes(image);
    return img.path;
  }

  Future<String> _saveAudio(Uint8List audio) async {
    String path =
        join(await dbHelper.getPath, 'audios', "${DateTime.now()}.mp3");
    File fileDef = File(path);
    await fileDef.create(recursive: true);
    File audi = await fileDef.writeAsBytes(audio);
    return audi.path;
  }

  Future<int> _storeLocally(TranslationModel translationModel) async {
    int id = await dbHelper.insertTranslation(translationModel);

    debugPrint('Translated data saved to database with id: $id');
    return id;
  }
}
