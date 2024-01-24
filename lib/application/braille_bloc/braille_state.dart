import 'package:equatable/equatable.dart';

abstract class BrailleState extends Equatable {}

class BrailleInitial extends BrailleState {
  @override
  List<Object?> get props => [];
}

class BrailleTranslationLoading extends BrailleState {
  @override
  List<Object?> get props => [];
}

class BrailleTranslationSuccess extends BrailleState {
  final List<String> translation;
  BrailleTranslationSuccess({required this.translation});

  @override
  List<Object?> get props => translation;
}

class BrailleTranslationFailure extends BrailleState {
  final String message;
  BrailleTranslationFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
