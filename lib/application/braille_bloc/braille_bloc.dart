import 'package:amharic_braille/application/braille_bloc/braille_events.dart';
import 'package:amharic_braille/application/braille_bloc/braille_state.dart';
import 'package:amharic_braille/application/models/translation_model.dart';
import 'package:amharic_braille/repository/braille_repsoitory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrailleBloc extends Bloc<BrailleEvent, BrailleState> {
  final BrailleRepository _brailleRepository = BrailleRepository();
  BrailleBloc() : super(BrailleInitial()) {
    on<TranscribeBraille>((event, emit) async {
      if (state is BrailleTranslationLoading) return;
      emit(BrailleTranslationLoading());
      try {
        final TranslationModel translation =
            await _brailleRepository.translateBraille(
          event.image,
        );
        emit(BrailleTranslationSuccess(translation: translation));
      } catch (e) {
        emit(BrailleTranslationFailure(message: e.toString()));
      }
    });

    on<GetRecents>((event, emit) async {
      if (state is BrailleRecentsLoading) return;
      emit(BrailleRecentsLoading());
      try {
        final recents = await _brailleRepository.getRecents();
        emit(BrailleRecentsSuccess(recents: recents));
      } catch (e) {
        emit(BrailleRecentsFailure(message: e.toString()));
      }
    });
  }
}
