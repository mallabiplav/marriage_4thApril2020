import 'package:equatable/equatable.dart';
import 'package:marriageappupdated/model/game_model.dart';
import 'package:marriageappupdated/model/player_model.dart';

abstract class PlayerBlocEvent extends Equatable {
  const PlayerBlocEvent();
}

class AddPlayer extends PlayerBlocEvent {
  final Player player;

  const AddPlayer(this.player);

  @override
  List<Object> get props => [player];
}

class Cancel extends PlayerBlocEvent{
  const Cancel();


  @override
  List<Object> get props => [];

}

class LoadListOfPlayers extends PlayerBlocEvent {
//  final String playerName;
  final List<Player> playerList;


  const LoadListOfPlayers(this.playerList);

  @override
  List<Object> get props => [playerList];
}

class DeletePlayer extends PlayerBlocEvent {
  final int index;

  const DeletePlayer(this.index);

  @override
  List<Object> get props => [index];
}

class CalculateScores extends PlayerBlocEvent {
  final int totalPlayers;
  final int sumOfMaal;


  const CalculateScores(this.totalPlayers, this.sumOfMaal);

  @override
  List<Object> get props => [totalPlayers, sumOfMaal];
}

class SetRules extends PlayerBlocEvent {
  final Game gamerules;


  const SetRules(this.gamerules);

  @override
  List<Object> get props => [gamerules];
}


