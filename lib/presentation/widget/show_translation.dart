import 'package:amharic_braille/application/models/translation_model.dart';
import 'package:flutter/material.dart';

class ShowTranslation extends StatelessWidget {
  const ShowTranslation({super.key, required this.translationModel});
  final TranslationModel translationModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('See Translation'),
        ),
        body: Column(
          children: [
            Image.memory(translationModel.image),
          ],
        ));
  }
}
