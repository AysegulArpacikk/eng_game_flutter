import 'package:eng_game_flutter/category/bloc/category_bloc.dart';
import 'package:eng_game_flutter/category/bloc/category_event.dart';
import 'package:eng_game_flutter/category/widget/categories.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_bloc.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_event.dart';
import 'package:eng_game_flutter/pairingWords/widget/pairing_word_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget pairingWordPage(PairingWordPageBloc bloc, List<dynamic> pairingWordList, int index) => Material(
    child: MultiBlocProvider(
      providers: [
        BlocProvider.value(
            value: bloc
              ..add(PairingWordPageInitializeEvent(pairingWordList: pairingWordList, index: index)))
      ],
      child: const PairWordsPage(),
    )
);

Widget categoriesPage(CategoryPageBloc bloc) => Material(
    child: MultiBlocProvider(
      providers: [
        BlocProvider.value(
            value: bloc
              ..add(CategoryPageInitializeEvent()))
      ],
      child: const CategoryPage(),
    )
);