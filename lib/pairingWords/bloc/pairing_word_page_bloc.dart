import 'dart:convert';

import 'package:eng_game_flutter/common/SessionStorageService.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_event.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PairingWordPageBloc extends Bloc<PairingWordPageEvent, PairingWordPageState> {
  SessionStorageService? sessionStorageService;

  PairingWordPageBloc() : super(PairingWordPageInitialState());

  @override
  Stream<PairingWordPageState> mapEventToState(PairingWordPageEvent event) async* {
    String response = await rootBundle.loadString("assets/json/pair_words.json");
    final data = await json.decode(response);

    if (event is PairingWordPageInitializeEvent){
      if(state is PairingWordPageFetchState) {
        yield PairingWordPageLoadingState();
      }

      yield PairingWordPageFetchState(wordList: event.pairingWordList);
    } else if (event is IsPairingWordCorrectEvent) {
      if(event.answerWord == event.mainWord) {
        yield CorrectAnswersState(message: "Tebrikler!!");
        yield PairingWordPageFetchState(wordList: data["pairWords"]);
      } else {
        yield FailedAnswersState(message: "Yanlış cevap!!");
        yield PairingWordPageFetchState(wordList: data["pairWords"]);
      }
    }
  }

  Future<bool> isCorrectAnswer(String answerWord, String mainWord) async {
    var storage = await SessionStorageService.getInstance();
    if(answerWord == mainWord) {
      storage!.savePairAnswer(true);
      return true;
    } else {
      storage!.savePairAnswer(false);
      return false;
    }

  }
}