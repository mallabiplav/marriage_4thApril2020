import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marriageappupdated/bloc/player_bloc_bloc.dart';
import 'package:marriageappupdated/bloc/player_bloc_event.dart';
import 'package:marriageappupdated/bloc/player_bloc_state.dart';
import 'package:marriageappupdated/model/game_model.dart';

class ScoreBoard extends StatefulWidget {
  final List playerList;
  final Game game;

  const ScoreBoard({
    Key key,
    @required this.playerList,this.game,
  }) : super(key: key);

  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  DataRow totalMoneyRow;
  List playerList;
  List scoreBoardList;
  List dataRowList;
  double iconSize = 50;

  @override
  Widget build(BuildContext context) {

    double columnSpacing;
    switch (widget.playerList.length) {
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
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: SafeArea(
          child: BlocBuilder<PlayerBlocBloc, PlayerBlocState>(
            builder: (context, state) {
              if (state is ScoreCalculated) {
                scoreBoardList = state.scoreBoardList;
                totalMoneyRow = state.totalMoneyRow;
                return Container(
                  padding: EdgeInsets.all(2),
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xfff0f7ff),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Icon(
                                Icons.arrow_back,
                                size: 30,
                              ),
                            ),
                            Text(
                              "Scoreboard",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                letterSpacing: 2,
                              ),
                            ),
                            Text(
                              "Rounds: ${((scoreBoardList.length) - 1).toString()}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              child: DataTable(
                                dataRowHeight: 50,
                                columnSpacing: columnSpacing,
                                columns:
                                    widget.playerList.map<DataColumn>((player) {
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
                      ),
                    ],
                  ),
                );
              }
              else{
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
  void getDataRows(scoreBoardList, totalMoneyRow) {
    dataRowList = scoreBoardList.asMap().entries.map<DataRow>((itemRow) {
      return DataRow(
        onSelectChanged: (value) {
          AlertDialog alert = AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
            title: Text("Do you want to delete this round?", style: TextStyle(fontSize: 15),),
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

Widget textView(List<Widget> list) {
  return Container(
    child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: list),
  );
}
//return Scaffold(
//body: Center(
//child: Container(
////          color: Colors.red,
//height: 300,
//width: 400,
//child: Column(
//children: <Widget>[
//Container(
////                color: Colors.green,
//height: 50,
//width: 300,
//child: ListView.builder(
//scrollDirection: Axis.horizontal,
//itemCount: widget.playerList.length,
//itemBuilder: (BuildContext context, int index) {
//return Row(
//children: <Widget>[
//Text(widget.playerList[index].playerName),
//SizedBox(width: 20,),
//],
//);
//}),
//),
//Container(
//color: Colors.red[100],
//height: 200,
//width: 300,
//child: ListView.builder(
////                  scrollDirection: Axis.vertical,
//itemCount: widget.scoreBoardList.length,
//itemBuilder: (BuildContext context, int index) {
//Color color;
//if (index % 2 == 0) {
//color = Colors.red[100];
//} else {
//color = Colors.red[200];
//}
//return Column(
//children: <Widget>[
//Container(
//color: color,
//height: 40,
//width: 300,
//child: ListView.builder(
//scrollDirection: Axis.horizontal,
//itemCount: widget.scoreBoardList[index].length,
//itemBuilder:
//(BuildContext context, int integerIndex) {
//Color color;
//if (index % 2 == 0) {
//color = Colors.red[300];
//} else {
//color = Colors.red[100];
//}
//print(widget.scoreBoardList[index].length);
//return Row(
//children: <Widget>[
//Container(
//height: 30,
//width: 30,
//color: color,
//child: Center(
//child: Text(widget
//    .scoreBoardList[index]
//[integerIndex]
//    .toString()),
//)),
//SizedBox(
//width: 40,
//),
//],
//);
//}),
//),
//SizedBox(
//height: 10,
//),
//],
//);
//},
//),
//)
//],
//),
//),
//),
//);
//
