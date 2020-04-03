import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'player_model.g.dart';

@HiveType()
class Player {
  @HiveField(20)
  String playerName;
  @HiveField(21)
  int maal;
  @HiveField(22)
  int pointValue;
  @HiveField(23)
  int totalPay;
  @HiveField(24)
  bool winner;
  @HiveField(25)
  bool seen;
  @HiveField(26)
  bool dubli;

  Player(
      {this.playerName,
      this.maal = 0,
      this.winner = false,
      this.seen = false,
      this.dubli = false,
      this.pointValue = 10,
      this.totalPay = 0});
}
