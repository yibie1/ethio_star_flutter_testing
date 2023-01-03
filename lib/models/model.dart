// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:hive/hive.dart';

part 'model.g.dart';

List<Data> dataFromJson(String str) =>
    List<Data>.from(json.decode(str).map((x) => Data.fromJson(x)));

String dataToJson(List<Data> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Data {
  Data({
    required this.name,
    required this.itam,
  });

  String name;
  List<Itam> itam;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        itam: List<Itam>.from(json["itam"].map((x) => Itam.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "itam": List<dynamic>.from(itam.map((x) => x.toJson())),
      };
}
@HiveType(typeId: 0)
class Itam {
  Itam({
    required this.itemName,
    required this.createdAt,
    required this.alarm,
    required this.object,
  });
  @HiveField(0)
  String itemName;
  @HiveField(1)
  String createdAt;
  @HiveField(2)
  int alarm;
  @HiveField(3)
  List<Object> object;

  factory Itam.fromJson(Map<String, dynamic> json) => Itam(
        itemName: json["item_name"],
        createdAt: json["created_at"],
        alarm: json["alarm"],
        object:
            List<Object>.from(json["object"].map((x) => Object.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "item_name": itemName,
        "created_at": createdAt,
        "alarm": alarm,
        "object": List<dynamic>.from(object.map((x) => x.toJson())),
      };
}
@HiveType(typeId: 1)
class Object {
  Object({
    required this.objectName,
    required this.satus,
    required this.hour,
    required this.day,
    required this.week,
  });
 @HiveField(0)
  String objectName;
  @HiveField(1)
  int satus;
  @HiveField(2)
  List<Hour> hour;
  @HiveField(3)
  List<Day> day;
  @HiveField(4)
  List<Week> week;

  factory Object.fromJson(Map<String, dynamic> json) => Object(
        objectName: json["object_name"],
        satus: json["satus"],
        hour: List<Hour>.from(json["hour"].map((x) => Hour.fromJson(x))),
        day: List<Day>.from(json["day"].map((x) => Day.fromJson(x))),
        week: List<Week>.from(json["week"].map((x) => Week.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "object_name": objectName,
        "satus": satus,
        "hour": List<dynamic>.from(hour.map((x) => x.toJson())),
        "day": List<dynamic>.from(day.map((x) => x.toJson())),
        "week": List<dynamic>.from(week.map((x) => x.toJson())),
      };
}
@HiveType(typeId: 2)
class Day {
  Day({
    required this.hour,
    required this.temperate,
  });
@HiveField(0)
  String hour;
  @HiveField(1)
  int temperate;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        hour: json["hour"],
        temperate: json["temperate "],
      );

  Map<String, dynamic> toJson() => {
        "hour": hour,
        "temperate ": temperate,
      };
}
@HiveType(typeId: 3)
class Hour {
  Hour({
    required this.minute,
    required this.temperate,
  });
 @HiveField(0)
  int minute;
  @HiveField(1)
  int temperate;

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        minute: json["minute"],
        temperate: json["temperate "],
      );

  Map<String, dynamic> toJson() => {
        "minute": minute,
        "temperate ": temperate,
      };
}
@HiveType(typeId: 4)
class Week {
  Week({
    required this.days,
    required this.temperate,
  });
 @HiveField(0)
  String days;
  @HiveField(1)
  int temperate;

  factory Week.fromJson(Map<String, dynamic> json) => Week(
        days: json["days"],
        temperate: json["temperate "],
      );

  Map<String, dynamic> toJson() => {
        "days": days,
        "temperate ": temperate,
      };
}
