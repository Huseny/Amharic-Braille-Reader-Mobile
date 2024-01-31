import 'package:flutter/material.dart';

class ComingSoonDialog extends StatelessWidget {
  const ComingSoonDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('Coming Soon'),
      content: Text('This feature will be available soon. Stay tuned!'),
    );
  }
}
