import 'package:amharic_braille/application/braille_bloc/braille_events.dart';
import 'package:amharic_braille/application/braille_bloc/braille_state.dart';
import 'package:amharic_braille/repository/braille_repsoitory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrailleBloc extends Bloc<BrailleEvent, BrailleState> {
  final BrailleRepository _brailleRepository = BrailleRepository();
  BrailleBloc() : super(BrailleInitial()) {
    on<TranscribeBraille>((event, emit) async {
      if (state is BrailleTranslationLoading) return;
      emit(BrailleTranslationLoading());
      try {
        final translation = await _brailleRepository.translateBraille(
          event.imagePath,
        );
        emit(BrailleTranslationSuccess(translation: translation));
      } catch (e) {
        emit(BrailleTranslationFailure(message: e.toString()));
      }
    });
  }
}
