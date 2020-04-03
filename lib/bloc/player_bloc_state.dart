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
  final List<String> calculatedScoreList;
  final List<List> scoreBoardList;
  final List<DataColumn> columnList;
  final List<DataRow> rowList;

  const ScoreCalculated(this.calculatedScoreList, this.scoreBoardList, this.columnList, this.rowList);

  @override
  List<Object> get props => [calculatedScoreList, scoreBoardList, columnList,rowList];
}
