import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/data_provider.dart';
import '../models/model.dart';

class Notfication extends StatefulWidget {
  Notfication({Key? key}) : super(key: key);

  @override
  State<Notfication> createState() => _NotficationState();
}

class _NotficationState extends State<Notfication> {
  Color colors = Color.fromARGB(255, 131, 129, 129);
  Color card_colors = Color.fromARGB(255, 131, 129, 129);
  List<String>? not_list;

  List<NotificationData> notification_list = [];

  void addnotification() {
    for (int i = 0; i < 6; i++) {
      var random = Random();
      String it = random.toString();
      var st = random.nextInt(3);
      notification_list.add(
        NotificationData("Itam A", "01 01 2023 6:59 am", 25 - i, st),
      );
    }
    //  print("object");
  }

  String? item_name;
  var _status;
  @override
  initState() {
    note_length();
    addnotification();
    getitem();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.87,
      child: ListView(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              const Gap(10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: FutureBuilder<List<Data>>(
                            future: DataProvider().getDatas(),
                            builder: (context, snapshot) {
                              final data = snapshot.data;
                              for (int i = 0; i > data!.length; i++) {
                                for (int k = 0; k > data[i].itam.length; k++) {
                                  for (int j = 0;
                                      j > data[i].itam[k].object.length;) {
                                    notification_list.add(
                                      NotificationData(
                                          data[i].itam[k].itemName,
                                          data[i].itam[k].createdAt,
                                          20 + i,
                                          data[i].itam[k].object[j].satus),
                                    );
                                  }
                                }
                              }

                              if (data.isNotEmpty) {
                                return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: notification_list.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    if (notification_list[index].status == 0) {
                                      colors = Colors.red;
                                      card_colors = Colors.red.withOpacity(0.2);
                                    } else if (notification_list[index]
                                            .status ==
                                        1) {
                                      colors = Colors.yellow;
                                      card_colors =
                                          Colors.yellow.withOpacity(0.2);
                                    } else {
                                      colors = Colors.grey;
                                      card_colors =
                                          Colors.grey.withOpacity(0.2);
                                    }

                                    return Dismissible(
                                      key: Key(
                                          notification_list.length.toString()),
                                      onDismissed: (direction) {
                                        setState(() {
                                          notification_list.removeAt(index);
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                          'Notification dismissed',
                                          style: TextStyle(color: Colors.black),
                                        )));
                                      },
                                      // Show a red background as the item is swiped away.
                                      background: Container(color: Colors.red),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Card(
                                              // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),

                                              color: card_colors,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Row(children: [
                                                  Column(children: [
                                                    Container(
                                                      width: 10,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: colors),
                                                    )
                                                  ]),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(notification_list[
                                                              index]
                                                          .created_at),
                                                      const Spacer(),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.dashboard),
                                                          Text(
                                                              notification_list[
                                                                      index]
                                                                  .item_name)
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 90,
                                                  ),
                                                  Column(
                                                    children: [
                                                      const Text(
                                                        "Temp:",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        notification_list[index]
                                                            .temp
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ]),
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  notification_list
                                                      .removeAt(index);
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.black,
                                                size: 40,
                                              ))
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }

                              return const Text("Ther is no Notiication");
                            })),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> setNotification(iname, createdat, temp, status) async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();

    NotificationData notificationData =
        NotificationData(iname, createdat, temp, status);
    String notification_data = jsonEncode(notificationData);
    print(notification_data);
    _pref.setString("note", notification_data);

    _pref.setInt("length", notification_list.length);

    // _pref.setStringList( "list", notification_list);
  }

  void note_length() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();

    _pref.setInt("length", 6);
  }

  void getitem() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    Map<String, dynamic> jsondetails = jsonDecode(_pref.getString("note")!);

    NotificationData notificationData = NotificationData.fromJson(jsondetails);
    if (jsondetails.isNotEmpty) {
      item_name = notificationData.item_name;
      _status = notificationData.status;
    }
  }
}

class NotificationData {
  String item_name, created_at;
  int temp, status;

  NotificationData(this.item_name, this.created_at, this.temp, this.status);

  NotificationData.fromJson(Map<String, dynamic> json)
      : item_name = json['item_name'],
        created_at = json['created_at'],
        temp = json['temp'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'item_name': item_name,
        'created_at': created_at,
        'temp': temp,
        'status': status
      };
}
