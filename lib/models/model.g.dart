// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItamAdapter extends TypeAdapter<Itam> {
  @override
  final int typeId = 0;

  @override
  Itam read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Itam(
      itemName: fields[0] as String,
      createdAt: fields[1] as String,
      alarm: fields[2] as int,
      object: (fields[3] as List).cast<Object>(),
    );
  }

  @override
  void write(BinaryWriter writer, Itam obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.itemName)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.alarm)
      ..writeByte(3)
      ..write(obj.object);
  }

  @override
  int get hashCode => typeId.hashCode;

  
}

class ObjectAdapter extends TypeAdapter<Object> {
  @override
  final int typeId = 1;

  @override
  Object read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Object(
      objectName: fields[0] as String,
      satus: fields[1] as int,
      hour: (fields[2] as List).cast<Hour>(),
      day: (fields[3] as List).cast<Day>(),
      week: (fields[4] as List).cast<Week>(),
    );
  }

  @override
  void write(BinaryWriter writer, Object obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.objectName)
      ..writeByte(1)
      ..write(obj.satus)
      ..writeByte(2)
      ..write(obj.hour)
      ..writeByte(3)
      ..write(obj.day)
      ..writeByte(4)
      ..write(obj.week);
  }

  @override
  int get hashCode => typeId.hashCode;


}

class DayAdapter extends TypeAdapter<Day> {
  @override
  final int typeId = 2;

  @override
  Day read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Day(
      hour: fields[0] as String,
      temperate: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Day obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.hour)
      ..writeByte(1)
      ..write(obj.temperate);
  }

  @override
  int get hashCode => typeId.hashCode;

}

class HourAdapter extends TypeAdapter<Hour> {
  @override
  final int typeId = 3;

  @override
  Hour read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hour(
      minute: fields[0] as int,
      temperate: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Hour obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.minute)
      ..writeByte(1)
      ..write(obj.temperate);
  }

  @override
  int get hashCode => typeId.hashCode;


}

class WeekAdapter extends TypeAdapter<Week> {
  @override
  final int typeId = 4;

  @override
  Week read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Week(
      days: fields[0] as String,
      temperate: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Week obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.days)
      ..writeByte(1)
      ..write(obj.temperate);
  }

  @override
  int get hashCode => typeId.hashCode;

}
