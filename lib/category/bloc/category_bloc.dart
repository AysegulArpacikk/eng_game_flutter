import 'dart:convert';

import 'package:eng_game_flutter/category/bloc/category_event.dart';
import 'package:eng_game_flutter/category/bloc/category_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPageBloc extends Bloc<CategoryPageEvent, CategoryPageState> {
  CategoryPageBloc() : super(CategoryPageInitialState());

  @override
  Stream<CategoryPageState> mapEventToState(CategoryPageEvent event) async* {
    String response = await rootBundle.loadString("assets/json/categories.json");
    final data = await json.decode(response);

    if(event is CategoryPageInitializeEvent) {
      yield CategoriesFetchedState(categories: data["category"]);
      return;
    }
  }

}