import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:eng_game_flutter/common/SessionStorageService.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_bloc.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_event.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'confetti.dart';

class PairWordsPage extends StatefulWidget {
  const PairWordsPage({Key? key}) : super(key: key);

  @override
  _PairWordsPageState createState() => new _PairWordsPageState();
}

class _PairWordsPageState extends State<PairWordsPage> {
  late ConfettiController _controllerCenter;
  late PairingWordPageBloc pairingWordPageBloc;
  SessionStorageService? sessionStorageService;
  bool isCorrect = false;
  bool isFalse = false;
  int index = 0;

  final AudioCache _audioCache = AudioCache(
    prefix: 'assets/',
    fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
  );

  @override
  void initState() {
    super.initState();
    pairingWordPageBloc = BlocProvider.of<PairingWordPageBloc>(context);
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PairingWordPageBloc, PairingWordPageState>(
        builder: (context, state) {
          if(state is PairingWordPageInitialState || state is PairingWordPageLoadingState) {
            return const Center(child: CircularProgressIndicator(strokeWidth: 5));
          } else if (state is PairingWordPageFetchState) {
            return Scaffold(body: SafeArea(child: _body(state, pairingWordPageBloc)));
          } else {
            return const Text("Sayfa bulunamadı!");
          }
        }) ;
  }

  Widget _body(PairingWordPageFetchState state, PairingWordPageBloc bloc) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text("Kelimeleri Eşle"),
        centerTitle: true,
        backgroundColor: Colors.green[200],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              //height: MediaQuery.of(context).size.height * 0.8,
              // decoration: BoxDecoration(
              //   borderRadius: const BorderRadius.all(Radius.circular(15)),
              //   border: Border.all(width: 1, color: Colors.grey),
              //   color: Colors.white,
              // ),
              child: state.wordList.length != index ? Column(
                children: [
                  progressBar(state),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(width: 1, color: Colors.white),
                      color: Colors.teal[200],
                    ),
                    child: Center(child: Text(state.wordList[index]["name"])),
                  ),
                  Container(
                    height: 250,
                    width: 200,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(width: 1, color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      state.wordList[index]["imageUrl"],
                      height: 20,
                      width: 20,
                    ),
                  ),
                  _answerList(state.wordList[index]["answers"], state.wordList[index]["correctAnswer"], bloc, state),
                  isCorrect ? _continueButton() : const Text("")
                ],
              ) : winnerCupAndMessage(state)
            ),
          ),
        ),
      ),
    );
  }

  Widget progressBar(PairingWordPageFetchState state) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 9, bottom: 9),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 80,
              animation: true,
              lineHeight: 20.0,
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              animationDuration: 2500,
              percent: index == 0 ? 0.0 : index / state.wordList.length,
              progressColor: Colors.amber,
            ),
          ),
        ),
        Image.asset(
          "assets/images/winner_cup.png",
          width: 38,
          height: 38,
        ),
      ],
    );
  }

  Widget winnerCupAndMessage(PairingWordPageFetchState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        progressBar(state),
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.asset(
            "assets/images/cup3.gif",
            width: 400,
            height: 400,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Text(
              "Tebrikler kazandın!",
            style: TextStyle(
              fontSize: 22,
              color: Colors.green[300],
              fontFamily: "Hind",
              fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    );
  }

  Widget _answerList(List<dynamic> answerList, String mainWord, PairingWordPageBloc bloc, PairingWordPageFetchState state) {
    List<Widget> list = [];
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 7;
    final double itemWidth = size.width / 2;

    for (var element in answerList) {
      var options = _elements(element!, mainWord, bloc, state);
      list.add(options);
    }

    return GridView.count(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      childAspectRatio: (itemWidth / itemHeight),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: list
    );
  }

  Widget _elements(dynamic element, String mainWord, PairingWordPageBloc bloc, PairingWordPageFetchState state) {
    int index = 0;
    return Stack(
      children: <Widget>[
        Confetti(controllerCenter: _controllerCenter),
        GestureDetector(
          onTap: () async {
            setState(() {
              element["isSelected"] = true;
              index = state.index;
            });
            context.read<PairingWordPageBloc>().add(
                IsPairingWordCorrectEvent(answerWord: element["name"], mainWord: mainWord, index: index));
            bool response = await bloc.isCorrectAnswer(element["name"], mainWord);
            if(response) {
              _audioCache.play("sounds/success.mp3");
              _controllerCenter.play();
              setState(() {
                isCorrect = true;
              });
            } else {
              showDialog(context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Yanlış cevap!"),
                    backgroundColor: Colors.red[100],
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    content: Row(children: [
                      const Text("Doğru cevap: "),
                      Text(
                        mainWord,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green
                        ),
                      )
                    ]),
                    actions: [
                      _continueWhenWrongAnswer()
                    ],
                  ),
                  barrierDismissible: false);
            }
          },
          child: Container(
              padding: const EdgeInsets.all(8),
              child: Center(child: Text(element["name"])),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(width: 1, color: Colors.white),
                color: (isCorrect && (element["name"] == mainWord)) ?
                        Colors.green :
                        Colors.green[100],
              ),
          ),
        )
      ],
    );
  }

  Widget _continueWhenWrongAnswer() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextButton(
            onPressed: () {
              setState(() {
                index++;
                isCorrect = false;
                _controllerCenter.stop();
              });
              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
            child: const Text("Sonraki Soru")
        )
      ],
    );
  }

  Widget _continueButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text('Sonraki Soru'),
        IconButton(
          icon: const Icon(Icons.arrow_forward_sharp),
          color: Colors.green,
          iconSize: 48,
          tooltip: 'Sonraki Soru',
          onPressed: () {
            setState(() {
              index++;
              isCorrect = false;
              _controllerCenter.stop();
            });
          },
        ),
      ],
    );
  }
}