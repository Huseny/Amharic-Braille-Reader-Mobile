import 'package:amharic_braille/application/braille_bloc/braille_bloc.dart';
import 'package:amharic_braille/application/braille_bloc/braille_state.dart';
import 'package:amharic_braille/presentation/widget/custom_app_bar.dart';
import 'package:amharic_braille/presentation/widget/custom_drawer.dart';
import 'package:amharic_braille/presentation/widget/homebody.dart';
import 'package:amharic_braille/presentation/widget/image_upload.dart';
import 'package:amharic_braille/presentation/widget/learn_braille.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  int currentDrawerPage = 0;

  void onDrawerTab(int id) {
    setState(() {
      currentDrawerPage = id;
    });
  }

  final List<Widget> _pages = const [
    HomeBody(),
    ImageUpload(),
    LearnBraille(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrailleBloc, BrailleState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: const CustomAppBar(),
            body: _pages[currentPage],
            drawer: CustomDrawer(
              currentPage: currentDrawerPage,
              onPageChanged: onDrawerTab,
            ),
            bottomNavigationBar: ConvexAppBar(
              backgroundColor: Colors.black, // <-- This works for fixed
              color: Colors.white,
              activeColor: const Color.fromRGBO(255, 221, 94, 1),
              initialActiveIndex: currentPage,
              elevation: 0,
              style: TabStyle.fixedCircle,
              items: const [
                TabItem(
                    icon: Icon(Icons.home_rounded),
                    title: 'Home',
                    isIconBlend: true),
                TabItem(
                    icon: Icon(Icons.camera_alt_rounded),
                    title: 'Upload Photo',
                    isIconBlend: true),
                TabItem(
                    icon: Icon(Icons.book_rounded),
                    title: 'Learn Braille',
                    isIconBlend: true),
              ],
              onTap: (int i) {
                setState(() {
                  currentPage = i;
                });
              },
            ),
          );
        });
  }
}
