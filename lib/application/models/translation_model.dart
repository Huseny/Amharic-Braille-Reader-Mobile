import 'dart:typed_data';

class TranslationModel {
  final String id;
  final Uint8List image;
  final String braille;
  final String translation;
  final DateTime createdAt;

  TranslationModel(
      {required this.id,
      required this.image,
      required this.braille,
      required this.translation,
      required this.createdAt});

  factory TranslationModel.fromJson(Map<String, dynamic> json) {
    return TranslationModel(
      id: json['id'] ?? "",
      image: json['image'] ?? "",
      braille: json['braille'] ?? "",
      translation: json['translation'] ?? "",
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
    );
  }
}
