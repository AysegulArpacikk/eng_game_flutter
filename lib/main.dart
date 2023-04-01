import 'package:eng_game_flutter/category/bloc/category_bloc.dart';
import 'package:eng_game_flutter/category/bloc/category_event.dart';
import 'package:eng_game_flutter/category/widget/categories.dart';
import 'package:eng_game_flutter/login/bloc/login_bloc.dart';
import 'package:eng_game_flutter/login/bloc/login_event.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_bloc.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_event.dart';
import 'package:eng_game_flutter/pairingWords/widget/pairing_word_page.dart';
import 'package:eng_game_flutter/tabbar/widget/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login/widget/login_or_register_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginPageBloc(
              )
                ..add(LoginOrRegisterPageInitializeEvent()),
              child: const LoginOrRegisterPage(),
            ),
            BlocProvider(
            create: (context) => PairingWordPageBloc(
            )
              ..add(PairingWordPageInitializeEvent()),
            child: const PairWordsPage(),
            ),
            BlocProvider(
              create: (context) => CategoryPageBloc(
              )
                ..add(CategoryPageInitializeEvent()),
              child: const CategoryPage(),
            ),
      ], child: TabNavigationBar(),
      )
    )
  );
}


