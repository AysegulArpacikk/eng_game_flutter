import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_bloc.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_event.dart';
import 'package:eng_game_flutter/pairingWords/widget/pairing_word_page.dart';
import 'package:eng_game_flutter/tabbar/widget/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
          providers: [
            BlocProvider(
            create: (context) => PairingWordPageBloc(
          //eventSender: FirebaseEventSender()
            )
              ..add(PairingWordPageInitializeEvent()),
            child: PairWordsPage(),
            ),
      ], child: TabNavigationBar(),
      )
    )
  );
}


