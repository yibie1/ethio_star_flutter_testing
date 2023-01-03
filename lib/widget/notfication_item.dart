import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:convert';
import 'package:ethiostar_testing/models/model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/model.dart';

class NotficatioItem extends StatefulWidget {
  const NotficatioItem({Key? key}) : super(key: key);

  @override
  State<NotficatioItem> createState() => _NotficatioItemState();
}

class _NotficatioItemState extends State<NotficatioItem> {
  final items = List<String>.generate(5, (i) => 'Item ${i + 1}');
  var _status = 1;
  List _notification = [];

  Future<List<Data>> getDatas() async {
    SharedPreferences sharedPreferences;
    final String response =
        await rootBundle.loadString('assets/json/item_data.json');
    final req = await json.decode(response);
    var list = req as List<dynamic>;
    // final body = req.body;

    // final datas = dataFromJson(body);
    var datas = list.map((e) => Data.fromJson(e)).toList();

    if (datas.isNotEmpty) {
      for (int i = 0; i > datas.length; i++) {
        for (int k = 0; k > datas[i].itam.length; k++) {
          for (int o = 0; o > datas[i].itam[k].object.length; o++) {
            _notification.add(datas[i].itam[k].itemName +
                ':' +
                datas[i].itam[k].object[o].objectName);
          }
        }
      }
    }

    return datas;
  }

  Color colors = Colors.white;

  @override
  void initState() {
    setState(() {
      if (_status == 0) {
        colors = Colors.red;
      } else if (_status == 1) {
        colors = Color.fromARGB(255, 222, 243, 33);
      } else {
        colors = Color.fromARGB(255, 104, 101, 101);
      }
    });
    getDatas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),

        color: Color(0xFFFFFEFE),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 60,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Row(children: [
            Column(children: [
              Container(
                width: 10,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: colors),
              )
            ]),
            const SizedBox(
              width: 8,
            ),
            Column(
              children: [
                Text("datae"),
                Spacer(),
                Row(
                  children: const [Icon(Icons.dashboard), Text("Item Abc")],
                )
              ],
            ),
            const SizedBox(
              width: 90,
            ),
            Column(
              children: const [Text("Temp:"), Spacer(), Text("23 *c")],
            ),
          ]),
        ));
  }
}
