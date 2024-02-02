import 'dart:io';

class TranslationModel {
  final String id;
  final File image;
  final String braille;
  final String translation;
  final File audio;
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
      'image': image.path,
      'braille': braille,
      'translation': translation,
      'audio': audio.path,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TranslationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TranslationModel(
      id: (json['id'] ?? "").toString(),
      // if the image is from the database, it is a path to the image, else it is a Uint8List
      image: json['image'] is String
          ? File(json['image'])
          : File.fromRawPath(json['image']),
      braille: json['braille'],
      translation: json['translation'],
      audio: json['audio'] is String
          ? File(json['audio'])
          : File.fromRawPath(json['audio']),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
    );
  }
}
