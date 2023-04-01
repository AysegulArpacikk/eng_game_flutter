import 'dart:async';

import 'package:eng_game_flutter/login/widget/login_or_register_page.dart';
import 'package:flutter/cupertino.dart';

class TabNavigationBar extends StatelessWidget {
  int? tabBarCount = 0;
  StreamController<int>? countController = StreamController<int>.broadcast();

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
    tabBar: CupertinoTabBar(
      backgroundColor: CupertinoColors.white,
      activeColor: CupertinoColors.black,
      inactiveColor: CupertinoColors.systemGrey,
      onTap: (index) {
        print('Clicked Tab $index');
      },
      items: const [
        BottomNavigationBarItem(
            label: 'Ana Sayfa',
            icon: Icon(CupertinoIcons.home)
        ),
        BottomNavigationBarItem(
            label: 'Hesabım',
            icon: Icon(CupertinoIcons.person_solid)
        )
      ],
    ),
    tabBuilder: (context, index){
      switch (index) {
        case 0:
          return CupertinoTabView(
              builder: (context) => const LoginOrRegisterPage());
        case 1:
        default:
          return CupertinoTabView(
              builder: (context) =>  Container(child: Text("Sayfa 2")));
      }
    },
  );
}