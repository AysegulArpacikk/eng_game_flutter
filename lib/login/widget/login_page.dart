import 'package:eng_game_flutter/common/widget/custom_routing.dart';
import 'package:eng_game_flutter/login/bloc/login_bloc.dart';
import 'package:eng_game_flutter/login/bloc/login_state.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_bloc.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_event.dart';
import 'package:eng_game_flutter/pairingWords/widget/pairing_word_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late PairingWordPageBloc _pairingWordPageBloc;

  @override
  void initState() {
    super.initState();
    _pairingWordPageBloc = BlocProvider.of<PairingWordPageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPageBloc, LoginPageState>(
        builder: (context, state) {
          if(state is LoginPageInitialState) {
            return Material(child: _body());
          } else {
            return const Text("Sayfa bulunamadı");
          }
        });
  }

  Widget _body() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.2,
      color: const Color.fromRGBO(246, 243, 209, 1.0),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Container(
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.width * 1.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(330)),
                  border: Border.all(width: 3, color: const Color.fromRGBO(167, 202, 206, 1.0), style: BorderStyle.solid),
                  color: const Color.fromRGBO(167, 202, 206, 1.0),
                  //color: const Color.fromRGBO(182, 156, 236, 1.0) -> MOR
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.only(top: 35, right: 35),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80), // Image border
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(80), // Image radius
                              child: Image.asset("assets/images/panda.png", fit: BoxFit.cover),
                            ),
                          )
                      )
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.only(top: 35, right: 35, left: 35),
                          child: const Text("Panda",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: const Color.fromRGBO(22, 99, 108, 1.0),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold
                              ))
                        )
                    ),
                  ],
                )),
          ),
          Align(
             alignment: Alignment.bottomLeft,
             child: Container(
               margin: const EdgeInsets.only(left: 50, right:50, bottom: 100),
               child: const TextField(
                 maxLength: 20,
                 decoration: InputDecoration(
                   border: OutlineInputBorder(),
                   hintText: 'Kullanıcı adı girin',
                 ),
               ),
             ),
           ),
           Align(
               alignment: Alignment.bottomRight,
               child: Container(
                   margin: const EdgeInsets.only(left: 50, right:50, bottom: 30),
                   child: _loginButton()
               )
           )
        ]
      ),
    );
  }

  Widget _loginButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
            'Giriş Yap',
            style: TextStyle(
                fontSize: 16,
                color: const Color.fromRGBO(90, 165, 173, 1.0),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold
            )
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_sharp),
          color: const Color.fromRGBO(90, 165, 173, 1.0),
          iconSize: 30,
          tooltip: 'Giriş Yap',
          onPressed: () {
            Navigator.of(context).push(CustomRouting(page: _pairingWordPage(_pairingWordPageBloc)).createRoute());
          },
        ),
      ],
    );
  }

  Widget _pairingWordPage(PairingWordPageBloc bloc) => Material(
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
              value: bloc
                ..add(PairingWordPageInitializeEvent()))
        ],
        child: const PairWordsPage(),
      )
  );


}