import 'package:equatable/equatable.dart';

abstract class BrailleEvent extends Equatable {}

class TranscribeBraille extends BrailleEvent {
  final String imagePath;
  TranscribeBraille({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}

class GetRecents extends BrailleEvent {
  @override
  List<Object?> get props => [];
}
