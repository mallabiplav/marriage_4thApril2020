// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerAdapter extends TypeAdapter<Player> {
  @override
  Player read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Player(
      playerName: fields[20] as String,
      maal: fields[21] as int,
      winner: fields[24] as bool,
      seen: fields[25] as bool,
      dubli: fields[26] as bool,
      pointValue: fields[22] as int,
      totalPay: fields[23] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(7)
      ..writeByte(20)
      ..write(obj.playerName)
      ..writeByte(21)
      ..write(obj.maal)
      ..writeByte(22)
      ..write(obj.pointValue)
      ..writeByte(23)
      ..write(obj.totalPay)
      ..writeByte(24)
      ..write(obj.winner)
      ..writeByte(25)
      ..write(obj.seen)
      ..writeByte(26)
      ..write(obj.dubli);
  }
}
