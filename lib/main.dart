import 'package:amharic_braille/application/braille_bloc/braille_bloc.dart';
import 'package:amharic_braille/presentation/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BrailleBloc(),
      child: MaterialApp(
        title: 'Amharic Braille Reader',
        home: const HomePage(),
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: "Jost",
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
