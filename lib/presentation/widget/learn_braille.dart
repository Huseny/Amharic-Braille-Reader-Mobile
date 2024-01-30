import 'package:amharic_braille/application/braille_bloc/braille_bloc.dart';
import 'package:amharic_braille/application/braille_bloc/braille_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearnBraille extends StatefulWidget {
  const LearnBraille({super.key});

  @override
  State<LearnBraille> createState() => _LearnBrailleState();
}

class _LearnBrailleState extends State<LearnBraille> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrailleBloc, BrailleState>(
      listener: (context, state) {},
      builder: (context, state) {
        return const Placeholder();
      },
    );
  }
}
