import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marriageappupdated/bloc/player_bloc_bloc.dart';
import 'package:marriageappupdated/bloc/player_bloc_event.dart';
import 'package:marriageappupdated/model/game_model.dart';

class SettingsPage extends StatefulWidget {
  final Game game;

  const SettingsPage({
    Key key,
    @required this.game,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
//  final rateController = TextEditingController();
  TextEditingController rateController;
  TextEditingController seenController;
  TextEditingController unSeenController;

//  final seenController = TextEditingController();
//  final unSeenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    rateController =
        TextEditingController(text: widget.game.ratePerPoint.toString());
    seenController =
        TextEditingController(text: widget.game.pointsForSeen.toString());
    unSeenController =
        TextEditingController(text: widget.game.pointsForUnseen.toString());
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    rateController.dispose();
    seenController.dispose();
    unSeenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            showCalculationRates(widget.game),
            Padding(
              padding: EdgeInsets.fromLTRB(190, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Done"),
                    onPressed: () {
                      if (rateController.text.isEmpty) {
                        widget.game.ratePerPoint = widget.game.ratePerPoint;
                      } else {
                        widget.game.ratePerPoint =
                            int.parse(rateController.text);
                      }
                      if (seenController.text.isEmpty) {
                        widget.game.pointsForSeen = widget.game.pointsForSeen;
                      } else {
                        widget.game.pointsForSeen =
                            int.parse(seenController.text);
                      }
                      if (unSeenController.text.isEmpty) {
                        widget.game.pointsForUnseen = widget.game.pointsForUnseen;
                      } else {
                        widget.game.pointsForUnseen =
                            int.parse(unSeenController.text);
                      }
                      setRules(widget.game);
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    child: Text("Cancel"),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            ),
          ],
        ),
//        Container(
//          padding: EdgeInsets.all(50),
//          child: Column(
//            children: <Widget>[
//              Row(
//                children: <Widget>[
//                  Text("Rate Per Point"),
//                  Container(
//                      height: 50,
//                      width: 50,
//                      child: TextField(
//
//                        decoration: InputDecoration(
//                          hintText: widget.game.ratePerPoint.toString(),
//                        ),
//                        keyboardType: TextInputType.numberWithOptions(),
//                        onChanged: (value) {
//                          widget.game.ratePerPoint = int.parse(value);
//                        },
//                      )),
//                ],
//              ),
//              Row(
//                children: <Widget>[
//                  Text("Points for seen"),
//                  Container(
//                      height: 50,
//                      width: 50,
//                      child: TextField(
//                        textAlign: TextAlign.center,
//
//                        decoration: InputDecoration(
//                          hintText: widget.game.pointsForSeen.toString(),
//                        ),
//                        keyboardType: TextInputType.numberWithOptions(),
//                        onChanged: (value) {
//                          widget.game.pointsForSeen = int.parse(value);
//                        },
//                      )),
//                ],
//              ),
//              Row(
//                children: <Widget>[
//                  Text("Points for unseen"),
//                  Container(
//                      height: 50,
//                      width: 50,
//                      child: TextField(
//                        textAlign: TextAlign.center,
//                        decoration: InputDecoration(
//                          hintText: widget.game.pointsForUnseen.toString(),
//                        ),
//                        keyboardType: TextInputType.numberWithOptions(),
//                        onChanged: (value) {
//                          widget.game.pointsForUnseen = int.parse(value);
//                        },
//                      )),
//                ],
//              ),
//              RaisedButton(
//                child: Text("Save"),
//                onPressed: () {
//                  setRules(context, widget.game);
//                  print(widget.game.ratePerPoint);
//                  Navigator.pop(context);
//                },
//              ),
//            ],
//          ),
//        ),
      ),
    );
  }

  Container showCalculationRates(game) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
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

//                      hintText: game.ratePerPoint.toString(),
                        ),
                    textAlign: TextAlign.center,
                    controller: rateController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
//                    onChanged: (value) {
//                      widget.game.ratePerPoint = int.parse(value);
//                    },
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
                    controller: seenController,
//    controller: TextEditingController(
//                        text: game.pointsForSeen.toString()),
                    textAlign: TextAlign.center,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
//                    onChanged: (value) {
//                      widget.game.pointsForSeen = int.parse(value);
//                    },
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
                    controller: unSeenController,

//    controller: TextEditingController(
//                        text: game.pointsForUnseen.toString()),
                    textAlign: TextAlign.center,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
//                    onChanged: (value) {
//                      widget.game.pointsForUnseen = int.parse(value);
//                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void setRules(Game game) {
    // ignore: close_sinks
    final playerBloc = BlocProvider.of<PlayerBlocBloc>(context);
    playerBloc.add(SetRules(game));
  }
}
