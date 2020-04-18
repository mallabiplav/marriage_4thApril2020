import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:marriageappupdated/model/game_model.dart';
import 'package:marriageappupdated/model/player_model.dart';
import 'package:marriageappupdated/model/previous_game_model.dart';
import './bloc.dart';

class PlayerBlocBloc extends Bloc<PlayerBlocEvent, PlayerBlocState> {
  String rupees = "₹";
  String dollar = "\$";
  String euro = "€";
  String pound = "£";
  List<Player> playerList = [];
  List calculatedScoreList;
  List scoreBoardList = [];
  Game game = new Game();
  List<DataColumn> columnList = [];
  List<DataRow> rowList = [];
  List<DataCell> cellList = [];
  List previousGames = [];
  List playerMaal = [];
  List totalMoneyList = [];
  List<DataCell> dataCellList = [];

//  List hiveBoxList = [];
  final previousGamesBox = Hive.box('previousGames');

//  List previousGamesList;
  PreviousGames previousGamesInstance = PreviousGames();

  @override
  PlayerBlocState get initialState => PlayerBlocInitial(game);

  @override
  Stream<PlayerBlocState> mapEventToState(
    PlayerBlocEvent event,
  ) async* {
    yield PlayerBlocInitial(game);
//    if (playerList.length > 0) {
//      yield PlayerLoaded(playerList, game);
//
////      if (scoreBoardList.isEmpty) {
////        print("Scoreboard: $scoreBoardList");
////      } else {
////        print("Scoreboard Not eMpty: $scoreBoardList");
////
////        getRows(scoreBoardList);
////        yield ScoreCalculated(scoreBoardList, columnList, rowList);
////      }
//    }
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
//        print("Player List: $playerList, Game: ${game.pointsForUnseen}");
        yield PlayerLoaded(playerList, game);
      }
    }
    if (event is DeletePlayer) {
      playerList.removeAt(event.index);
      if (playerList.length > 0) {
        yield PlayerLoaded(playerList, game);
      }
    }
    if (event is DeletePreviousGames) {
      previousGamesBox.clear();
      bool deleted = false;
      yield PlayerDeleted(deleted);
      yield PlayerBlocInitial(game);
    }
    if (event is DeletePreviousGame) {
      previousGamesBox.get(0);
      event.previousGamesList.removeAt(event.index);
      previousGamesBox.put(0, event.previousGamesList);
      bool deleted = false;
      yield PlayerDeleted(deleted);
      yield PlayerBlocInitial(game);
    }
    if (event is SetPreviousGameState) {
      game = event.game;
      playerList = event.playerList;
    }
    if (event is GoToHomePage) {
      game = new Game();
      playerList = [];
      calculatedScoreList = [];
      columnList = [];
      rowList = [];
      cellList = [];
      playerMaal = [];
      scoreBoardList = [];
      previousGames = [];
      previousGamesInstance = new PreviousGames();
//      previousGamesBox.close();
      Hive.close();
//      yield PlayerBlocInitial(game);
    }
    if (event is LoadPreviousGame) {
//      print("Previous Gmaes: $previousGames");
      previousGames = previousGamesBox.get(0);
//      print("Previous Gmaes: $previousGames");

      game = event.previousGamesInstance.game;
      playerList = event.previousGamesInstance.playerList;
      scoreBoardList = event.previousGamesInstance.scoreBoardList;


      DataRow totalMoneyRow = getTotalMoney(playerList, scoreBoardList);

      yield ScoreCalculated(scoreBoardList, totalMoneyRow);
    }
    if(event is GetTotalMoney){
      print("ScoreboadList $scoreBoardList");
      DataRow totalMoneyRow = getTotalMoney(playerList, scoreBoardList);
      previousGamesInstance.scoreBoardList = scoreBoardList;
      previousGamesInstance.playerList = playerList;
      previousGamesInstance.game = game;
      previousGames.removeAt(0);
      previousGames.insert(0, previousGamesInstance);
      previousGamesBox.put(0, previousGames);
      yield ScoreCalculated(scoreBoardList, totalMoneyRow);
    }
    if (event is SubmitEvent) {
      previousGamesInstance = new PreviousGames();
      previousGamesInstance.playerList = playerList;
      previousGamesInstance.scoreBoardList = scoreBoardList;
      previousGamesInstance.game = game;

      void insertAtZero(previousGamesInstance, previousGames) {
        previousGames.insert(0, previousGamesInstance);
      }

//      print("PreviousGAmeBox ==== ${previousGamesBox.isEmpty}");
      if (previousGamesBox.isEmpty == true) {
        previousGames = [];
        previousGamesBox.put(0, previousGames);
        insertAtZero(previousGamesInstance, previousGames);
      } else {
        previousGames = previousGamesBox.getAt(0);
        if (previousGames.length >= 5) {
          previousGames.removeLast();
        }
        insertAtZero(previousGamesInstance, previousGames);
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
//            print('$myTotal = ${player.maal} X ${event.totalPlayers}');
            player.totalPay = (myTotal - toBeSubtracted) * game.ratePerPoint;
//            print(
//                '${player.totalPay} = ${myTotal} - ${toBeSubtracted} * ${game.ratePerPoint}');
//
//            print(player.totalPay);

            tempList.add(player.totalPay);
          } else {
//            print("Only Seen");

            player.pointValue = 3;
            int toBeSubtracted = event.sumOfMaal + player.pointValue;
            int myTotal = player.maal * event.totalPlayers;
            player.totalPay = (myTotal - toBeSubtracted) * game.ratePerPoint;
//            print(player.totalPay);
            tempList.add(player.totalPay);
//            print(tempList);
          }
        } else {
          winnerIndex = playerList.indexOf(player);
//          print(winnerIndex);
        }

        calculatedScoreList.add(statement);
      }
      int temp = 0;
      for (var each in tempList) {
        temp += each;
      }

      tempList.insert(winnerIndex, temp * -1);
      scoreBoardList.insert(0, tempList);

      print("AAAA");

//      getColumns(playerList);
//      getRows(playerList, scoreBoardList);
      DataRow totalMoneyRow = getTotalMoney(playerList, scoreBoardList);

      print(totalMoneyRow);
      previousGamesInstance.scoreBoardList = scoreBoardList;
      previousGamesInstance.playerList = playerList;
      previousGamesInstance.game = game;
      previousGames.removeAt(0);
      previousGames.insert(0, previousGamesInstance);
      previousGamesBox.put(0, previousGames);
      yield ScoreCalculated(scoreBoardList, totalMoneyRow);
    }
  }

  void addPreviousGames(hiveBoxList) {
    final previousGames = Hive.box('previousGames');
    previousGames.add(hiveBoxList);
  }

  void getColumns(playerList) {
    columnList = [];
    for (Player player in playerList) {
      DataColumn column = DataColumn(
          label: Text(
        player.playerName,
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black),
      ));
      columnList.add(column);
    }
  }

  void getRow(playerList, scoreBoardList) {
//   var scoreBoardMap =  scoreBoardList.map((index) => DataRow(
//            cells: index.map(
//          (p) => DataCell(p),
//        )));
    var row = scoreBoardList.map((index) {
      return DataRow(
        cells: index.map((p){
          return DataCell(p);
        }).toList(),
      );
    });

    print(row);
  }

  void getRows(playerList, scoreBoardList) {
    DataRow totalMoneyRow = getTotalMoney(playerList, scoreBoardList);
    rowList = [];

    for (var i in scoreBoardList) {
      var color;
      cellList = [];
      for (var p in i) {
        if (p < 0) {
          color = Colors.red[100];
        } else if (p > 0) {
          color = Colors.green[100];
        } else {
          color = Colors.white;
        }

        DataCell cell = DataCell(Container(
          padding: EdgeInsets.fromLTRB(0, 7, 7, 3),
//          color: Colors.yellow,
//            height: 60,
          width: 60,
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: color,
                    ),
                    child: Text(
                      p.toString(),
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(
                    (p / game.ratePerPoint).abs().toStringAsFixed(0),
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ));
        cellList.add(cell);
      }
      DataRow row = DataRow(cells: cellList);

      rowList.add(row);
    }
    rowList.insert(0, totalMoneyRow);
  }

  DataRow getTotalMoney(playerList, scoreBoardList) {
    totalMoneyList = [];
    int i = 0;
    var score = 0;
    dataCellList = [];
    while (i < playerList.length) {
      score = 0;
      for (var each in scoreBoardList) {
        score += each[i];
      }
      totalMoneyList.add(score);
      i++;
    }
    dataCellList = [];

    for (var each in totalMoneyList) {
      DataCell cell = DataCell(Text(
        "$rupees ${each.toString()}",
        style: TextStyle(fontWeight: FontWeight.w500),
      ));
      dataCellList.add(cell);
    }

    DataRow dataRow = DataRow(cells: dataCellList);
//    print(dataRow);

    return dataRow;
  }
}
