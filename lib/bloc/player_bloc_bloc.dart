import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:marriageappupdated/model/game_model.dart';
import 'package:marriageappupdated/model/player_model.dart';
import './bloc.dart';

class PlayerBlocBloc extends Bloc<PlayerBlocEvent, PlayerBlocState> {
  final List<Player> playerList = [];
  List<String> calculatedScoreList;
  List<List> scoreBoardList = [];
  Game game = new Game();
  List<DataColumn> columnList = [];
  List<DataRow> rowList = [];
  List<DataCell> cellList = [];
  List previousGames = [];
  List currentGame = [];
  List playerMaal = [];
  final contactsBox = Hive.box('previousGames');


  @override
  PlayerBlocState get initialState => PlayerBlocInitial(game);

  @override
  Stream<PlayerBlocState> mapEventToState(
    PlayerBlocEvent event,
  ) async* {
    yield PlayerBlocInitial(game);
    currentGame = [];
    if (playerList.length > 0) {
      print(scoreBoardList);
      if (scoreBoardList.isEmpty) {
        currentGame.add(playerList);
        yield PlayerLoaded(playerList, game);
      } else {
        yield ScoreCalculated(
            calculatedScoreList, scoreBoardList, columnList, rowList);
      }
    }
    if (playerList.length <= 0) {
      yield PlayerBlocInitial(game);
    }
    if (event is Cancel) {
      playerList.clear();
      yield PlayerBlocInitial(game);
    }
    if (event is SetRules) {
      game = event.gamerules;
    }
    if (event is AddPlayer) {
      playerList.insert(0, event.player);
      if (playerList.length > 0) {
        yield PlayerLoaded(playerList, game);
      }
    }
    if (event is DeletePlayer) {
      playerList.removeAt(event.index);
      if (playerList.length > 0) {
        yield PlayerLoaded(playerList, game);
      }
    }
    if (event is CalculateScores) {
      calculatedScoreList = [];
      String statement;
      List tempList = [];
      columnList = [];
      rowList = [];
      cellList = [];
      int winnerIndex;
      playerMaal = [];

      for (Player player in playerList) {
//        print(player.playerName);
//        print(player.seen);
//        print(player.winner);
//        print(player.dubli);
        if (player.seen != true) {
//          print("Unseen");
          player.pointValue = game.pointsForUnseen;
          player.totalPay =
              (event.sumOfMaal + player.pointValue) * game.ratePerPoint * -1;
//          print(player.totalPay);
          tempList.add(player.totalPay);
        } else if (!player.winner && player.seen) {
          if (player.dubli && player.winner) {
            player.pointValue = 0;
            int toBeSubtracted = event.sumOfMaal + player.pointValue;

//            print("Dubli and Winner");
            player.maal = player.maal + 5;
            int myTotal = (player.maal) * event.totalPlayers;
            player.totalPay = (myTotal - toBeSubtracted) * game.ratePerPoint;
//            print(player.totalPay);

            tempList.add(player.totalPay);
          } else if (player.dubli) {
//            print("Dubli");
            player.pointValue = 0;
            int toBeSubtracted = event.sumOfMaal + player.pointValue;
            int myTotal = player.maal * event.totalPlayers;
            print('$myTotal = ${player.maal} X ${event.totalPlayers}');
            player.totalPay = (myTotal - toBeSubtracted) * game.ratePerPoint;
            print(
                '${player.totalPay} = ${myTotal} - ${toBeSubtracted} * ${game.ratePerPoint}');

            print(player.totalPay);

            tempList.add(player.totalPay);
          } else {
//            print("Only Seen");

            player.pointValue = 3;
            int toBeSubtracted = event.sumOfMaal + player.pointValue;
            int myTotal = player.maal * event.totalPlayers;
            player.totalPay = (myTotal - toBeSubtracted) * game.ratePerPoint;
//            print(player.totalPay);

            tempList.add(player.totalPay);
            print(tempList);
          }
        } else {
          winnerIndex = playerList.indexOf(player);
          print(winnerIndex);
        }

        calculatedScoreList.add(statement);
      }
      int temp = 0;
      for (var each in tempList) {
        temp += each;
      }

      tempList.insert(winnerIndex, temp * -1);
      scoreBoardList.insert(0, tempList);

//      if (player.seen == false) {
//        statement =
//        ("${player.playerName} is unseen, will pay: ${player.totalPay}");
//      } else if (player.totalPay > 0) {
//        statement = ("${player.playerName} wins ${player.totalPay}");
//      } else if (player.totalPay < 0) {
//        statement = ("${player.playerName} needs to pay ${player.totalPay}");
//      } else if (player.totalPay == 0) {
//        statement =
//        ("${player.playerName} does not pay anything. Score: ${player.totalPay}");
//      }

      for (Player player in playerList) {
        DataColumn column = DataColumn(
            label: Text(
          player.playerName,
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black),
        ));
        columnList.add(column);
      }
      print(scoreBoardList);

      for (var i in scoreBoardList) {
        cellList = [];
        for (var p in i) {
          DataCell cell = DataCell(Text(p.toString()));
          cellList.add(cell);
        }
        DataRow row = DataRow(cells: cellList);

        rowList.add(row);
      }

      print(scoreBoardList);
      List rowsAndColumn = [];
      rowsAndColumn.add(columnList);
      rowsAndColumn.add(rowList);

      addPreviousGames(scoreBoardList, game);
      yield ScoreCalculated(
          calculatedScoreList, scoreBoardList, columnList, rowList);
    }
  }

  void addPreviousGames(listOfRows, gameSettings) {
    final previousGames = Hive.box('previousGames');
    previousGames.add(listOfRows);
    previousGames.add(gameSettings);
  }
}
