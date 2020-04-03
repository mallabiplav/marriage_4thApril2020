//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marriageappupdated/bloc/player_bloc_bloc.dart';
import 'package:marriageappupdated/bloc/player_bloc_event.dart';
import 'package:marriageappupdated/model/game_model.dart';
import 'package:marriageappupdated/model/player_model.dart';
import 'package:marriageappupdated/screen/settings_page.dart';

class HomePage extends StatelessWidget {
  final Player player = new Player();
  final Game gameRules = new Game();
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          padding: EdgeInsets.all(10),
          height: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
          child: Center(
            child: TextField(
              controller: myController,
              textCapitalization: TextCapitalization.words,
              onSubmitted: (value) {
                player.playerName = value;
                addToList(context, player);
              },
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Add New Player...",
                hintStyle: TextStyle(
                    color: Colors.black54, fontStyle: FontStyle.italic),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: Colors.blue[100])
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(color: Colors.blue[100])
                ),

                suffixIcon: GestureDetector(
                    onTap: () {
                      player.playerName = myController.text;
                      addToList(context, player);
                    },
                    child: Icon(Icons.add)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void addToList(BuildContext context, Player player) {
    // ignore: close_sinks
    final playerBloc = BlocProvider.of<PlayerBlocBloc>(context);
    playerBloc.add(AddPlayer(player));
  }
}
