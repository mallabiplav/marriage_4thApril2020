import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:marriageappupdated/model/game_model.dart';
import 'package:marriageappupdated/model/player_model.dart';

abstract class PlayerBlocState extends Equatable {
  const PlayerBlocState();
}

class PlayerBlocInitial extends PlayerBlocState {
  final Game gameRules;

  const PlayerBlocInitial(this.gameRules);
  @override
  List<Object> get props => [gameRules];
}

class PlayerLoading extends PlayerBlocState {
  const PlayerLoading();

  @override
  List<Object> get props => [];
}

class PlayerLoaded extends PlayerBlocState {
  final List<Player> playerList;
  final Game game;

  const PlayerLoaded(this.playerList, this.game);

  @override
  List<Object> get props => [playerList];
}


class ScoreCalculated extends PlayerBlocState {
//  final List<String> calculatedScoreList;
  final List scoreBoardList;
  final DataRow totalMoneyRow;

  const ScoreCalculated( this.scoreBoardList, this.totalMoneyRow);

  @override
  List<Object> get props => [scoreBoardList, totalMoneyRow];
}

class PlayerDeleted extends PlayerBlocState {
  final bool deletedPlayer;
//  final List<String> calculatedScoreList;


  const PlayerDeleted(this.deletedPlayer);

  @override
  List<Object> get props => [deletedPlayer];
}


