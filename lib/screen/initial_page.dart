import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:marriageappupdated/bloc/player_bloc_bloc.dart';
import 'package:marriageappupdated/bloc/player_bloc_event.dart';
import 'package:marriageappupdated/bloc/player_bloc_state.dart';
import 'package:marriageappupdated/model/game_model.dart';
import 'package:marriageappupdated/model/player_model.dart';
import 'package:marriageappupdated/screen/game_page.dart';
import 'package:marriageappupdated/screen/settings_page.dart';

import 'home_page.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  @override
  void initState() {
    super.initState();
    Hive.registerAdapter(GameAdapter());
  }
//  Player player;
  Game game;

  int num = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox('previousGames'),
      builder: (context, snapshot) {
        Hive.registerAdapter(GameAdapter());
        if (snapshot.connectionState == ConnectionState.done) {
          print(num);
          print("SSSS");
          print(snapshot.data.length);
          print(snapshot.data.get(23));
          print("AAA");
          num += 1;
          if (snapshot.hasError) {
            return Container();
          } else {
            return Scaffold(
              backgroundColor: Colors.blue[100],
              resizeToAvoidBottomPadding: false,
              body: SafeArea(
                child: Container(
                  alignment: Alignment.center,
                  child: BlocListener<PlayerBlocBloc, PlayerBlocState>(
                    listener: (context, state) {},
                    child: BlocBuilder<PlayerBlocBloc, PlayerBlocState>(
                      builder: (context, state) {
                        if (state is PlayerBlocInitial) {
                          game = state.gameRules;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              HomePage(),
                              showCalculationRates(game),
                              newGamePreviousGame(),
                              Expanded(child: previousGame()),
                            ],
                          );
                        } else if (state is PlayerLoaded) {
                          game = state.game;
                          return listOfPlayers(state.playerList, state.game);
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ),
              ),
            );
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget newGamePreviousGame() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xfff0f7ff)),
      child: Column(
        children: <Widget>[
          Text(
            "To start a new game, add a new player in the text box.",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "To continue a previous game, choose a game below.",
            style: TextStyle(fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Container previousGame() {
    return Container(
      height: 300,
      width: 400,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xfff0f7ff)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Previous Games: ",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Container showCalculationRates(game) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
      padding: EdgeInsets.all(20),
      height: 180,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xfff0f7ff)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 40,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white70,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 170,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Rate per Point: ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  height: 35,
                  width: 35,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: game.ratePerPoint.toString(),
                    ),
                    onTap: () {
                      setState(() {
                        InputDecoration(
                          hintText: "AA",
                        );
                      });
                    },
                    textAlign: TextAlign.center,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                    onChanged: (value) {
                      game.ratePerPoint = int.parse(value);
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 40,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white70,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 170,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Points for Seen: ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  height: 35,
                  width: 35,
                  child: TextField(
                    controller: TextEditingController(
                        text: game.pointsForSeen.toString()),
                    textAlign: TextAlign.center,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                    onChanged: (value) {
                      game.pointsForSeen = int.parse(value);
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 40,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white70,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 170,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Points for Unseen: ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  height: 35,
                  width: 35,
                  child: TextField(
                    controller: TextEditingController(
                        text: game.pointsForUnseen.toString()),
                    textAlign: TextAlign.center,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                    onChanged: (value) {
                      game.pointsForUnseen = int.parse(value);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listOfPlayers(List playerList, game) {
    return Container(
      child: Column(
        children: <Widget>[
          HomePage(),
          showCalculationRates(game),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xfff0f7ff),
//                gradient: LinearGradient(
//                  begin: Alignment.topCenter,
//                  end: Alignment.bottomCenter,
//                  colors: [
//                    Colors.green[200],
//                    Colors.green[200],
//                    Colors.green[200],
//                    Colors.green[100],
//                    Colors.green[100],
//                    Colors.green[100],
//                    Colors.grey[100],
//                  ],
//                ),
            ),
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Container(
                  height: 450,
                  child: Center(
                    child: ListView.builder(
//                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: playerList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: Center(
                              child: Card(
                            elevation: 10,
                            margin: EdgeInsets.all(5),
                            child: ListTile(
                              contentPadding: EdgeInsets.fromLTRB(20, 0, 25, 0),
                              title: Text(
                                playerList[index].playerName,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              leading: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.teal[100],
                                  ),
                                  child: Center(
                                      child: Text(
                                    (index + 1).toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ))),
                              trailing: GestureDetector(
                                  onTap: () {
                                    // ignore: close_sinks
                                    final playerBloc =
                                        BlocProvider.of<PlayerBlocBloc>(
                                            context);
                                    playerBloc.add(DeletePlayer(index));
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red[200],
                                    size: 25,
                                  )),
                            ),
                          )),
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: RaisedButton(
                            child: Text("Submit"),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                      value: BlocProvider.of<PlayerBlocBloc>(
                                          context),
                                      child: GamePage(
                                        playerList: playerList,
                                      ))));
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: RaisedButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              // ignore: close_sinks
                              final playerBloc =
                                  BlocProvider.of<PlayerBlocBloc>(context);
                              playerBloc.add(Cancel());
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Total Players: ${(playerList.length).toString()}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
