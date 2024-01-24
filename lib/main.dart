import 'package:amharic_braille/presentation/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amharic Braille Reader',
      home: const HomePage(),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.jost().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
