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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(50),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Rate Per Point"),
                  Container(
                      height: 50,
                      width: 50,
                      child: TextField(

                        decoration: InputDecoration(
                          hintText: widget.game.ratePerPoint.toString(),
                        ),
                        keyboardType: TextInputType.numberWithOptions(),
                        onChanged: (value) {
                          widget.game.ratePerPoint = int.parse(value);
                        },
                      )),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Points for seen"),
                  Container(
                      height: 50,
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,

                        decoration: InputDecoration(
                          hintText: widget.game.pointsForSeen.toString(),
                        ),
                        keyboardType: TextInputType.numberWithOptions(),
                        onChanged: (value) {
                          widget.game.pointsForSeen = int.parse(value);
                        },
                      )),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Points for unseen"),
                  Container(
                      height: 50,
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: widget.game.pointsForUnseen.toString(),
                        ),
                        keyboardType: TextInputType.numberWithOptions(),
                        onChanged: (value) {
                          widget.game.pointsForUnseen = int.parse(value);
                        },
                      )),
                ],
              ),
              RaisedButton(
                child: Text("Save"),
                onPressed: () {
                  setRules(context, widget.game);
                  print(widget.game.ratePerPoint);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setRules(BuildContext context, Game game) {
    // ignore: close_sinks
    final playerBloc = BlocProvider.of<PlayerBlocBloc>(context);
    playerBloc.add(SetRules(game));
  }
}
