import 'package:hive/hive.dart';
import 'package:marriageappupdated/model/player_model.dart';

import 'game_model.dart';

part 'previous_game_model.g.dart';


@HiveType()
class PreviousGames{
  @HiveField(31)
  List<Player> playerList;
  @HiveField(32)
  Game game;
  @HiveField(33)
  List scoreBoardList;

  PreviousGames({
    this.playerList,
    this.game,
    this.scoreBoardList
});


}