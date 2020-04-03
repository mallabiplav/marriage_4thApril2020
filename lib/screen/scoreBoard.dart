import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScoreBoard extends StatefulWidget {
  final List<DataColumn> columnList;
  final List<DataRow> dataRow;

  const ScoreBoard({
    Key key,
    @required this.columnList,
    this.dataRow,
  }) : super(key: key);

  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  List<DataColumn> columnList;
  List<DataRow> dataRow;
  double iconSize = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: DataTable(
                columnSpacing: 3,
                columns: widget.columnList,
                rows: widget.dataRow,
              ),
            ),
          ),
        ),
      ),
    );
  }
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
