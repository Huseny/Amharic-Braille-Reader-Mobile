import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class BrailleEvent extends Equatable {}

class TranscribeBraille extends BrailleEvent {
  final File image;
  TranscribeBraille({required this.image});

  @override
  List<Object?> get props => [image];
}

class GetRecents extends BrailleEvent {
  @override
  List<Object?> get props => [];
}
