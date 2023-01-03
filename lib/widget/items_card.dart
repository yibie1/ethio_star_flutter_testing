import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ethiostar_testing/models/items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'item_chart_details.dart';

// class ItemCard extends StatelessWidget {
//   const ItemCard({Key? key, required this.items}) : super(key: key);
//   final Items items;

//   @override
//   Widget build(BuildContext context) {
//     // final TextStyle? textStyle = Theme.of(context).textTheme.displayLarge;

//   }
// }

class ItemCard extends StatefulWidget {
  ItemCard({Key? key, required this.item}) : super(key: key);
  late Items item;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  List _items = [];
  Future<void> readJson() async {
    final String response =
    await rootBundle.loadString('assets/loadjson/item_data.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }

  @override
  void initState() {
    super.initState();
    // Call the readJson method when the app starts
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 1, horizontal: 2),
        key: ValueKey(_items),
        color: Color(0xFFFFFEFE),
        child: CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            autoPlay: false,
          ),
          items: [_items.length].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text("Iteam A"),
                         IconButton(
                      iconSize: 30,
                      color: Color.fromARGB(255, 15, 14, 14),
                      onPressed: () {
                        showModalBottomSheet<void>(
                            context: (context),
                            enableDrag: true,
                            isScrollControlled: true,
                            isDismissible: true,
                           // transitionAnimationController: controller,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) {
                               return   ItemChartDetail(item: "",);
                            });
                      },
                      icon: const Icon(
                        Icons.notification_add,
                      ),
                    ),
                      ]),
                );
              },
            );
          }).toList(),
        ));
  }
}
