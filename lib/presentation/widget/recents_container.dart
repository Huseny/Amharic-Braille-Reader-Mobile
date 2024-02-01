import 'package:amharic_braille/application/models/translation_model.dart';
import 'package:amharic_braille/presentation/widget/show_translation.dart';
import 'package:amharic_braille/repository/format_date.dart';
import 'package:flutter/material.dart';

class RecentContainer extends StatelessWidget {
  final TranslationModel recent;
  const RecentContainer({super.key, required this.recent});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShowTranslation(translationModel: recent))),
      leading: Image.memory(
        recent.image,
      ),
      title: Text(
        recent.translation,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        FormatDateTime().getTimeAgo(recent.createdAt),
        style: const TextStyle(color: Colors.grey, fontSize: 10),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
