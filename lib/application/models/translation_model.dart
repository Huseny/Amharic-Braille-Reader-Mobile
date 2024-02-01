import 'dart:typed_data';

class TranslationModel {
  final String id;
  final Uint8List image;
  final String braille;
  final String translation;
  final Uint8List audio;
  final DateTime createdAt;

  TranslationModel(
      {required this.id,
      required this.image,
      required this.braille,
      required this.translation,
      required this.audio,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'image': image,
      'braille': braille,
      'translation': translation,
      'audio': audio,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TranslationModel.fromJson(Map<String, dynamic> json) {
    return TranslationModel(
      id: (json['id'] ?? "").toString(),
      image: json['image'] ?? "",
      braille: json['braille'] ?? "",
      translation: json['translation'] ?? "",
      audio: json['audio'] ?? "",
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
    );
  }
}
