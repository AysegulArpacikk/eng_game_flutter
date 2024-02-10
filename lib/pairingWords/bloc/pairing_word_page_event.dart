import 'package:equatable/equatable.dart';

abstract class PairingWordPageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class PairingWordPageInitializeEvent extends PairingWordPageEvent {
  List<dynamic> pairingWordList;
  int index;

  PairingWordPageInitializeEvent({this.pairingWordList = const [], this.index = 0});
}

class IsPairingWordCorrectEvent extends PairingWordPageEvent {
  final String answerWord;
  final String mainWord;
  final int index;

  IsPairingWordCorrectEvent({this.answerWord = "", this.mainWord = "", this.index = 0});
}