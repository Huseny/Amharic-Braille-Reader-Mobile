import 'package:amharic_braille/application/models/translation_model.dart';
import 'package:flutter/material.dart';

class RecentContainer extends StatelessWidget {
  final TranslationModel recent;
  const RecentContainer({super.key, required this.recent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Braille image
          Expanded(
            flex: 1,
            child: Image.asset(
              recent.image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
              width: 10), // Add some spacing between the image and translation
          // Translation
          Text(
            recent.translation,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
