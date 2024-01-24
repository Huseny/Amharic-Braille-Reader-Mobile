import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final int id;
  final String title;
  final IconData icon;
  final bool isSelected;
  final void Function(int) onTab;

  const DrawerItem(
      {super.key,
      required this.id,
      required this.icon,
      required this.title,
      required this.onTab,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTab(id);
      },
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? Colors.grey[300] : Colors.transparent,
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                icon,
                size: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
