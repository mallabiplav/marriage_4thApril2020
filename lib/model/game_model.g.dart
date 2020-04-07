// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameAdapter extends TypeAdapter<Game> {
  @override
  Game read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Game(
      ratePerPoint: fields[10] as int,
      pointsForSeen: fields[11] as int,
      pointsForUnseen: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Game obj) {
    writer
      ..writeByte(3)
      ..writeByte(10)
      ..write(obj.ratePerPoint)
      ..writeByte(11)
      ..write(obj.pointsForSeen)
      ..writeByte(12)
      ..write(obj.pointsForUnseen);
  }
}
