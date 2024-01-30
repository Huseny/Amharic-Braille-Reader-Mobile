import 'package:amharic_braille/presentation/widget/drawer_item.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    super.key,
    required this.currentPage,
    required this.onPageChanged,
  });

  final int currentPage;
  final void Function(int) onPageChanged;

  final List<List> drawerEntries = [
    ["Home", Icons.home_outlined],
    ["About the App", Icons.info_outline_rounded],
    ["Who are we?", Icons.people_alt_outlined],
    ["Privacy Policy", Icons.privacy_tip_outlined],
    ["Feedback", Icons.feedback_outlined],
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(
                          MediaQuery.of(context).size.width * 0.5, 50),
                      bottomRight: Radius.elliptical(
                          MediaQuery.of(context).size.width * 0.5, 50))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Amharic Braille Reader",
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "version 1.0",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    drawerEntries.length,
                    (index) => DrawerItem(
                          id: index,
                          icon: drawerEntries[index][1],
                          title: drawerEntries[index][0],
                          onTab: onPageChanged,
                          isSelected: index == currentPage,
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
