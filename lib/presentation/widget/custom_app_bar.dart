import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Text('Amharic Braille Reader'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.inbox),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
