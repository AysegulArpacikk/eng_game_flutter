import 'package:equatable/equatable.dart';

abstract class PairingWordPageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class PairingWordPageInitializeEvent extends PairingWordPageEvent {
  List<dynamic> pairingWordList;

  PairingWordPageInitializeEvent({this.pairingWordList = const []});
}

class IsPairingWordCorrectEvent extends PairingWordPageEvent {
  final String answerWord;
  final String mainWord;

  IsPairingWordCorrectEvent({this.answerWord = "", this.mainWord = ""});
}