import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Amharic Braille Reader'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
