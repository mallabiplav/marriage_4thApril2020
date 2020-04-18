import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marriageappupdated/model/game_model.dart';
import 'package:marriageappupdated/model/player_model.dart';
import 'package:marriageappupdated/model/previous_game_model.dart';

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
class DeletePreviousGames extends PlayerBlocEvent {
  const DeletePreviousGames();

  @override
  List<Object> get props => [];
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

class SubmitEvent extends PlayerBlocEvent {
//  final PreviousGames previousGamesInstance;

  const SubmitEvent();

  @override
  List<Object> get props => [];
}
class LoadPreviousGame extends PlayerBlocEvent {
  final PreviousGames previousGamesInstance;

  const LoadPreviousGame(this.previousGamesInstance);

  @override
  List<Object> get props => [previousGamesInstance];
}

class SetPreviousGameState extends PlayerBlocEvent {
  final Game game;
  final List<Player> playerList;
  final List scoreBoardList;

  const SetPreviousGameState(this.game, this.playerList, this.scoreBoardList);

  @override
  List<Object> get props => [game, playerList, scoreBoardList];
}

class DeletePreviousGame extends PlayerBlocEvent{
  final List previousGamesList;
  final int index;
  const DeletePreviousGame(this.previousGamesList, this.index);

  @override
  List<Object> get props => [previousGamesList, index];

}
class GetTotalMoney extends PlayerBlocEvent{
  const GetTotalMoney();

  @override
  List<Object> get props => [];

}

class GoToHomePage extends PlayerBlocEvent{

  const GoToHomePage();

  @override
  List<Object> get props => [];

}

class PlayerDeletedEvent extends PlayerBlocEvent{

  const PlayerDeletedEvent();

  @override
  List<Object> get props => [];

}

