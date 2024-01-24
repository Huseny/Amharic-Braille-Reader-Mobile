import 'package:amharic_braille/presentation/widget/custom_app_bar.dart';
import 'package:amharic_braille/presentation/widget/custom_drawer.dart';
import 'package:amharic_braille/presentation/widget/homebody.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  void onTab(int id) {
    setState(() {
      currentPage = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: const HomeBody(),
      drawer: CustomDrawer(
        currentPage: currentPage,
        onPageChanged: onTab,
      ),
    );
  }
}
