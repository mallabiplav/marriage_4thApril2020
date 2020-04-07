// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'previous_game_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreviousGamesAdapter extends TypeAdapter<PreviousGames> {
  @override
  PreviousGames read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PreviousGames(
      playerList: (fields[31] as List)?.cast<Player>(),
      game: fields[32] as Game,
      scoreBoardList: (fields[33] as List)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, PreviousGames obj) {
    writer
      ..writeByte(3)
      ..writeByte(31)
      ..write(obj.playerList)
      ..writeByte(32)
      ..write(obj.game)
      ..writeByte(33)
      ..write(obj.scoreBoardList);
  }
}
