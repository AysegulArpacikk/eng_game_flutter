import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:eng_game_flutter/common/SessionStorageService.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_bloc.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_event.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_state.dart';
import 'package:eng_game_flutter/pairingWords/widget/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PairWordsPage extends StatefulWidget {
  PairWordsPage({Key? key}) : super(key: key);

  @override
  _PairWordsPageState createState() => new _PairWordsPageState();
}

class _PairWordsPageState extends State<PairWordsPage> {
  late ConfettiController _controllerCenter;
  late PairingWordPageBloc pairingWordPageBloc;
  SessionStorageService? sessionStorageService;
  bool isCorrect = false;
  int index = 0;

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
            return BlocListener<PairingWordPageBloc, PairingWordPageState>(
              listener: (context, state) {
                if(state is CorrectAnswersState) {
                  AlertDialogModal(message: state.message);
                } if(state is FailedAnswersState) {
                  AlertDialogModal(message: state.message);
                }
              },
                child: Scaffold(
                   body: _deneme(state, pairingWordPageBloc)
                ),
            );
          } else {
            return const Text("Sayfa bulunamadı!");
          }
        }) ;
  }

  Widget _deneme(PairingWordPageFetchState state, PairingWordPageBloc bloc) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text("Kelimeleri Eşle"),
        centerTitle: true,
        backgroundColor: Colors.green[200],
      ),
      body: Center(
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
                _answerList(state.wordList[index]["answers"], state.wordList[index]["correctAnswer"], bloc),
                isCorrect ? _continueButton() : const Text("")
              ],
            ) : winnerCupAndMessage(state)
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
        Text(
            "Tebrikler kazandın!",
          style: TextStyle(
            fontSize: 22,
            color: Colors.green[300],
            fontFamily: "Hind",
            fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }

  Widget _answerList(List<dynamic> answerList, String mainWord, PairingWordPageBloc bloc) {
    List<Widget> list = [];
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 7;
    final double itemWidth = size.width / 2;

    for (var element in answerList) {
      var menu = _elements(element!, mainWord, bloc);
      list.add(menu);
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

  Widget _elements(dynamic element, String mainWord, PairingWordPageBloc bloc) {
    return Stack(
      children: <Widget>[
        confetti(),
        GestureDetector(
          onTap: () async {
            context.read<PairingWordPageBloc>().add(
                IsPairingWordCorrectEvent(answerWord: element["name"], mainWord: mainWord));
            bool response = await bloc.isCorrectAnswer(element["name"], mainWord);
            if(response) {
              _controllerCenter.play();
              setState(() {
                isCorrect = true;
              });
            } else {
              const AlertDialogModal(message: "Yanlış cevap!");
            }
          },
          child: Container(
              padding: const EdgeInsets.all(8),
              child: Center(child: Text(element["name"])),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(width: 1, color: Colors.white),
                color: isCorrect && (element["name"] == mainWord) ?
                        Colors.green :
                        Colors.green[100],
              ),
          ),
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

  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  Widget confetti() {
    return Align(
      alignment: Alignment.center,
      child: ConfettiWidget(
        confettiController: _controllerCenter,
        blastDirectionality: BlastDirectionality
            .explosive, // don't specify a direction, blast randomly
        shouldLoop:
        true, // start again as soon as the animation is finished
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple
        ], // manually specify the colors to be used
        createParticlePath: drawStar, // define a custom shape/path.
      ),
    );
  }
}