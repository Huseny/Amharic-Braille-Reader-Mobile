import 'package:amharic_braille/application/models/translation_model.dart';
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
  final TranslationModel translation;
  BrailleTranslationSuccess({required this.translation});

  @override
  List<Object?> get props => [
        translation.id,
        translation.image,
        translation.braille,
        translation.translation,
        translation.createdAt,
      ];
}

class BrailleTranslationFailure extends BrailleState {
  final String message;
  BrailleTranslationFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class BrailleRecentsLoading extends BrailleState {
  @override
  List<Object?> get props => [];
}

class BrailleRecentsSuccess extends BrailleState {
  final List<TranslationModel> recents;
  BrailleRecentsSuccess({required this.recents});

  @override
  List<Object?> get props => recents;
}

class BrailleRecentsFailure extends BrailleState {
  final String message;
  BrailleRecentsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
