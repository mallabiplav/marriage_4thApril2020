import 'package:hive/hive.dart';

part 'game_model.g.dart';

@HiveType()
class Game{
  @HiveField(10)
  int ratePerPoint;
  @HiveField(11)
  int pointsForSeen;
  @HiveField(12)
  int pointsForUnseen;

  Game({this.ratePerPoint = 10,this.pointsForSeen = 3, this.pointsForUnseen = 10, });
}