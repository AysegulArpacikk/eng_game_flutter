
import 'dart:convert';

import 'package:eng_game_flutter/category/bloc/a1/a1_event.dart';
import 'package:eng_game_flutter/category/bloc/a1/a1_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class A1PageBloc extends Bloc<A1PageEvent, A1PageState> {
  A1PageBloc() : super(A1PageInitialState());

  @override
  Stream<A1PageState> mapEventToState(A1PageEvent event) async* {
    String response = await rootBundle.loadString("assets/json/pair_words.json");
    final data = await json.decode(response);

    if(event is A1PageInitializeEvent) {
      yield A1FetchedState(a1Questions: data["pairWords"]);
      return;
    }
  }
}