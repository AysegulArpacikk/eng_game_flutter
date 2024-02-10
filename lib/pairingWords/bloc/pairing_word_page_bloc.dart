import 'dart:convert';

import 'package:eng_game_flutter/common/SessionStorageService.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_event.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PairingWordPageBloc extends Bloc<PairingWordPageEvent, PairingWordPageState> {

  PairingWordPageBloc() : super(PairingWordPageInitialState());

  @override
  Stream<PairingWordPageState> mapEventToState(PairingWordPageEvent event) async* {
    var storage = await SessionStorageService.getInstance();
    String response = await rootBundle.loadString("assets/json/categories.json");
    String a1Response = await rootBundle.loadString("assets/json/a1_words.json");
    String a2Response = await rootBundle.loadString("assets/json/a2_words.json");
    String b1Response = await rootBundle.loadString("assets/json/b1_words.json");
    String b2Response = await rootBundle.loadString("assets/json/b2_words.json");
    String c1Response = await rootBundle.loadString("assets/json/c1_words.json");
    String c2Response = await rootBundle.loadString("assets/json/c2_words.json");
    final data = await json.decode(response);
    final a1Data = await json.decode(a1Response);
    final a2Data = await json.decode(a2Response);
    final b1Data = await json.decode(b1Response);
    final b2Data = await json.decode(b2Response);
    final c1Data = await json.decode(c1Response);
    final c2Data = await json.decode(c2Response);

    if (event is PairingWordPageInitializeEvent) {
      if(state is PairingWordPageFetchState) {
        yield PairingWordPageLoadingState();
      }
      storage?.saveCategoryGroupIndex(event.index);
      yield PairingWordPageFetchState(wordList: event.pairingWordList, index: event.index);
    } else if (event is IsPairingWordCorrectEvent) {
      var index = storage?.retrieveCategoryGroupIndex();
      var wordList = prepareCategoryWords(index, a1Data, a2Data, b1Data, b2Data, c1Data, c2Data);
      yield PairingWordPageFetchState(wordList: wordList);
      // if(event.answerWord == event.mainWord) {
      //   yield CorrectAnswersState(message: "Tebrikler!!");
      //   var index = storage?.retrieveCategoryGroupIndex();
      //   var wordList = prepareCategoryWords(index, a1Data, a2Data, b1Data, b2Data, c1Data, c2Data);
      //   yield PairingWordPageFetchState(wordList: wordList);
      // } else {
      //   yield FailedAnswersState(message: "Yanlış cevap!!");
      // }
    }
  }

  List<dynamic> prepareCategoryWords(int? index, a1Data, a2Data, b1Data, b2Data, c1Data, c2Data) {
    if (index == 0) {
      return a1Data["pairWords"];
    } else if (index == 1) {
      return a2Data["pairWords"];
    } else if (index == 2) {
      return b1Data["pairWords"];
    } else if (index == 3) {
      return b2Data["pairWords"];
    } else if (index == 4) {
      return c1Data["pairWords"];
    }
    return c2Data["pairWords"];
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