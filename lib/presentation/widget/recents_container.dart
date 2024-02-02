import 'package:amharic_braille/application/models/translation_model.dart';
import 'package:amharic_braille/presentation/widget/show_translation.dart';
import 'package:amharic_braille/repository/format_date.dart';
import 'package:flutter/material.dart';

class RecentContainer extends StatelessWidget {
  final TranslationModel recent;
  const RecentContainer({super.key, required this.recent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Delete'),
              content: const Text('Are you sure you want to delete this?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // delete the translation
                    Navigator.of(context).pop();
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          }),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShowTranslation(translationModel: recent))),
      child: ListTile(
        leading: Image.file(
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
      ),
    );
  }
}
