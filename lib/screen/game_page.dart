import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:marriageappupdated/bloc/player_bloc_bloc.dart';
import 'package:marriageappupdated/bloc/player_bloc_event.dart';
import 'package:marriageappupdated/bloc/player_bloc_state.dart';
import 'package:marriageappupdated/main.dart';
import 'package:marriageappupdated/model/game_model.dart';
import 'package:marriageappupdated/model/player_model.dart';
import 'package:marriageappupdated/screen/initial_page.dart';
import 'package:marriageappupdated/screen/scoreBoard.dart';
import 'package:marriageappupdated/screen/settings_page.dart';

class GamePage extends StatefulWidget {
  final List playerList;
  final Game game;

  const GamePage({
    Key key,
    @required this.playerList,
    this.game,
  }) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int totalMaal;
  var sum = 0;
  bool rad = false;

  List dataRowList;

//  Game game;
  List scoreBoardList;
  List columnList;
  List rowList;
  int i = 0;

  DataRow totalMoneyRow;
  List playerList;
  List listOfPlayerNames = [];

//  @override
//  void initState(){
//    super.initState();
//    scoreBoardListFunc(playerList);
//    print(listOfPlayerNames);
//  }
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
////    BlocProvider.of<PlayerBlocBloc>(context)
////        .add(CalculateScores(playerList.length, totalMaal));
//  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: WillPopScope(
        onWillPop: () {
          print("Pooperd");
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => MyApp()),
            (Route<dynamic> route) => false,
          );
          // ignore: close_sinks
          final playerBloc = BlocProvider.of<PlayerBlocBloc>(context);
          playerBloc.add(GoToHomePage());
//            Hive.close();
        },
        child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.blue[100],
              resizeToAvoidBottomPadding: false,
              body: Stack(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 55, 0, 0),
                      child: BlocListener<PlayerBlocBloc, PlayerBlocState>(
                        listener: (context, state) {
//                          print('bloc listener: $state');
                        },
                        child: BlocBuilder<PlayerBlocBloc, PlayerBlocState>(
                          // ignore: missing_return
                          builder: (context, state) {
                            if (state is PlayerBlocInitial) {
//                          game = state.gameRules;
//                          print('game rate: ${game.ratePerPoint}');
                              return buildPlayerLoaded();
                            } else if (state is ScoreCalculated) {
                              scoreBoardList = state.scoreBoardList;
                              totalMoneyRow = state.totalMoneyRow;
                              if (scoreBoardList.length > 0) {
                                return Column(
                                  children: <Widget>[
                                    buildPlayerLoaded(),
                                    scoreBoard(widget.playerList,
                                        scoreBoardList, totalMoneyRow),
                                  ],
                                );
                              }
                              else{
                                return Column(
                                  children: <Widget>[
                                    buildPlayerLoaded(),
                                  ],
                                );

                              }
//                              columnList = state.columnList;
//                              print(columnList);
//                              rowList = state.rowList;
//                              for (var each in rowList) {
////                                print("Each: $each");
//                              }
//                              print(rowList);
//                              print("ScoreBoard = $scoreBoardList}");
                            } else {
                              return CircularProgressIndicator();
                            }
//                        else if (state is PlayerLoaded) {
//                          print("Player Loaed $i");
//                          i++;
//                          game = state.game;
//                          return Column(
//                            children: <Widget>[
//                              buildPlayerLoaded(context),
////                              scoreBoard(widget.playerList, scoreBoardList,
////                                  columnList, rowList),
//                            ],
//                          );
//                        }
                          },
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => MyApp()));
                              // ignore: close_sinks
                              final playerBloc =
                                  BlocProvider.of<PlayerBlocBloc>(context);
                              playerBloc.add(GoToHomePage());
                              Hive.close();
                            },
                            child: Icon(
                              Icons.home,
                              size: 30.0,
                            )),
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ScoreBoard(
                                          playerList: widget.playerList,
                                          game: widget.game,
                                        )));
                              },
                              child: Chip(
                                backgroundColor: Colors.black87,
                                label: Text(
                                  "Scoreboard",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) =>
                                          SettingsPage(game: widget.game)));
                                },
                                child: Icon(
                                  Icons.settings,
                                  size: 30,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget buildPlayerLoaded() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Container(
        height: 630,
        decoration: BoxDecoration(

//            gradient: LinearGradient(
//              begin: Alignment.topCenter,
//              end: Alignment.bottomCenter,
//              colors: [
//                Colors.blue[200],
//                Colors.blue[100],
//                Colors.white,
//              ],
//            ),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xfff0f7ff),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Winner",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Seen",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Dubli",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Maal",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 0,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  padding: EdgeInsets.all(10),
                  height: 500,
                  width: 400,
                  decoration: BoxDecoration(
                      color: Color(0xfff0f7ff),
//                      gradient: LinearGradient(
//                        begin: Alignment.topCenter,
//                        end: Alignment.bottomCenter,
//                        colors: [
//                          Colors.red[200],
//                          Colors.red[100],
//                          Colors.red[200],
//                        ],
//                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: widget.playerList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var player = widget.playerList[index];
                        return Card(
                            elevation: 10,
                            color: Colors.white,
                            child: buildPlayerWidget(player));
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xfff0f7ff),

                borderRadius: BorderRadius.circular(10),
//                  gradient: LinearGradient(
//                      begin: Alignment.topCenter,
//                      end: Alignment.bottomCenter,
//                      colors: [Colors.red[100], Colors.red[100]])
              ),
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Calculate"),
                      onPressed: () {
//                        print(game.ratePerPoint);
                        int totalPlayers = widget.playerList.length;
                        sum = 0;
                        int totalWinner = 0;
                        for (Player player in widget.playerList) {
                          if (player.winner) {
                            totalWinner = 1;
                          }
                          sum += player.maal;
                          if (player.dubli && player.winner) {
                            sum = sum + 5;
                          }
                        }
                        if (totalWinner != 1) {
                          final snackBar = SnackBar(
                            content: Text('Please select a winner.'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                // Some code to und `o the change.
                              },
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        } else {
                          totalMaal = sum;
                          calculateList(totalPlayers, totalMaal);
                        }
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Last Game Maal: ",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          sum.toString(),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget scoreBoard(playerList, scoreBoardList, totalMoneyRow) {
    double columnSpacing;
    switch (playerList.length) {
      case (2):
        columnSpacing = 150;
        break;
      case (3):
        columnSpacing = 90;
        break;
      case (4):
        columnSpacing = 50;
        break;
      default:
        columnSpacing = 20;
        break;
    }
    if (scoreBoardList == null || scoreBoardList.isEmpty) {
      return Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.fromLTRB(15, 0, 15, 5),
          decoration: BoxDecoration(
            color: Color(0xfff0f7ff),
            borderRadius: BorderRadius.circular(10),
          ));
    } else {
//      print("PlayerList: $playerList, ${playerList.length}");
//      print("scoreBoardList: $scoreBoardList, ${scoreBoardList.length}");
//      print("columnList: $columnList, ${columnList.length}");
//      print("rowList: $rowList, ${rowList.length}");
      return Expanded(
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.fromLTRB(15, 0, 15, 5),
          decoration: BoxDecoration(
            color: Color(0xfff0f7ff),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
//                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
//                      color: Colors.green[100],
                    ),
                    height: 180,
                    alignment: Alignment.topCenter,
                    child: DataTable(
                      dataRowHeight: 50,
                      columnSpacing: columnSpacing,
                      columns: widget.playerList.map<DataColumn>((player) {
                        getDataRows(scoreBoardList, totalMoneyRow);
                        return DataColumn(
                          label: Text(player.playerName),
                        );
                      }).toList(),
                      rows: dataRowList,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget buildPlayerWidget(Player player) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
            width: 60,
            height: 20,
            child: Text(
              player.playerName,
              style: TextStyle(fontWeight: FontWeight.w500),
            )),
        Checkbox(
          activeColor: Colors.green[300],
          value: player.winner,
          onChanged: (value) {
            for (Player eachPlayer in widget.playerList) {
              eachPlayer.winner = false;
            }
            setState(() {
              player.winner = value;
              if (player.winner) {
                player.seen = true;
              }
            });
          },
        ),
        Switch(
          value: player.seen,
          activeColor: Colors.green[300],
          onChanged: (value) {
            setState(() {
              player.seen = value;
              if (!player.seen) {
                player.winner = false;
                player.dubli = false;
                player.maal = 0;
              }
            });
          },
        ),
        Switch(
          value: player.dubli,
          activeColor: Colors.green[300],
          onChanged: (value) {
            setState(() {
              player.dubli = value;
              if (player.dubli) {
                player.seen = true;
              }
            });
          },
        ),
        Container(
            padding: EdgeInsets.all(0),
            height: 30,
            width: 30,
            child: TextField(
              controller: TextEditingController(text: player.maal.toString()),

              enabled: player.seen,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              onChanged: (value) {
                player.maal = int.parse(value);
              },
//              onSubmitted: (value) {
//                player.maal = int.parse(value);
//              },
            )),
      ],
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void scoreBoardListFunc(playerList) {
    for (var each in playerList) {
      Text text = Text(each);
      rowList.add(text);
    }
  }

  void calculateList(int totalPlayers, int totalMaal) {
    // ignore: close_sinks
    final playerBloc = BlocProvider.of<PlayerBlocBloc>(context);
    playerBloc.add(CalculateScores(totalPlayers, totalMaal));
  }

  void getDataRows(scoreBoardList, totalMoneyRow) {
    dataRowList = scoreBoardList.asMap().entries.map<DataRow>((itemRow) {
      AlertDialog alert = AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
        title: Text(
          "Do you want to delete this round?",
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          FlatButton(
            child: Text("Yes"),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop('alert');

              // ignore: close_sinks
              final playerBloc = BlocProvider.of<PlayerBlocBloc>(context);
              playerBloc.add(GetTotalMoney());
              scoreBoardList.removeAt(itemRow.key);
            },
          ),
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop('alert');
            },
          ),
        ],
      );

      return DataRow(
        onSelectChanged: (value) {
          setState(() {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
          });
        },
        cells: itemRow.value.map<DataCell>((p) {
          var color;
          if (p < 0) {
            color = Colors.red[100];
          } else if (p > 0) {
            color = Colors.green[100];
          } else {
            color = Colors.white;
          }
          return DataCell(
            Stack(
              children: <Widget>[
                Center(
                  child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: color,
                      ),
                      child: Text(p.toString())),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Text(
                      (p / widget.game.ratePerPoint).abs().toStringAsFixed(0),
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                    )),
              ],
            ),
          );
        }).toList(),
      );
    }).toList();

    dataRowList.insert(0, totalMoneyRow);
    print(dataRowList);
  }
}
