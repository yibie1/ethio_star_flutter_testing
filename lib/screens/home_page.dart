import 'dart:ffi';

import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ethiostar_testing/widget/item_chart_details.dart';
import 'package:ethiostar_testing/widget/notfication.dart';
import 'package:ethiostar_testing/widget/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:reorderable_grid/reorderable_grid.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
import '../models/data_provider.dart';
import '../models/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController controller;
  // final items = List<Items>;
  late int counter;
  List<String> ficon = [];
  List<Favourites> fav_list = [];
  List<Objects> obj_list = [];
  Color colors = Colors.black;
  Color _iconColor = Colors.transparent;
  double _status = 2;

  void contain(List<Favourites> fav_list, Favourites favourites) {
    if (fav_list.contains(favourites)) {
      fav_list.remove(favourites);
    }
  }

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  late Future<String> item_name;
  bool _expanded = false;
  String? selectedValue;
  bool isVisible = true;
  bool isNotified = false;
  final List _items = [];
  late List data;

  late IconData _icon = Icons.star_border;
  late Color _color = Colors.transparent;
  // final List<String> savedWords = [];

  // final _myfav = Hive.box("ItemBox");
  int length = 0;
  var isExpanded = false;
  int currentIndex = 0;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final itm = fav_list.removeAt(oldIndex);
      fav_list.insert(newIndex, itm);
    });
  }

  @override
  void initState() {
    addobject();
    getlength();

    // prefs = await SharedPreferences.getInstance();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(seconds: 1);
    controller.reverseDuration = const Duration(seconds: 1);
    controller.drive(CurveTween(curve: Curves.linear));
    setState(() {
      if (_status == 0) {
        colors = Colors.red.withOpacity(0.5);
      } else if (_status == 1) {
        colors = Color.fromARGB(255, 120, 121, 119);
      } else if (_status == 2) {
        colors = Color.fromARGB(255, 252, 252, 252);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color.fromARGB(255, 10, 113, 209),
              Color.fromARGB(255, 211, 207, 199)
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(children: [
            Column(
              children: <Widget>[
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Center(
                    child: Container(
                        width: 100,
                        height: 50,
                        child: Image.asset('assets/images/flag.png')),
                  ),
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Welcome Back",
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    ),
                    const SizedBox(width: 4),
                    Badge(
                      badgeContent: Text(fav_list.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          )),
                      toAnimate: true,
                      badgeColor: Colors.red,
                      position: BadgePosition.topStart(top: 0, start: 0),
                      child: IconButton(
                        iconSize: 30,
                        color: Colors.white,
                        onPressed: () {
                          showModalBottomSheet<void>(
                              context: (context),
                              enableDrag: true,
                              isScrollControlled: true,
                              isDismissible: true,
                              transitionAnimationController: controller,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) {
                                return Notfication();
                              });
                        },
                        icon: const Icon(
                          Icons.notifications,
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 35,
                      color: Colors.white,
                      onPressed: () {
                        // showModalBottomSheet<void>(
                        //     context: (context),
                        //     enableDrag: true,
                        //     transitionAnimationController: controller,
                        //     isScrollControlled: true,
                        //     isDismissible: true,
                        //     builder: (context) {
                        //       return const SideBar();
                        //     });

                        showModalSideSheet<Void>(
                            width: MediaQuery.of(context).size.width * 0.9,
                            context: (context),
                            barrierDismissible: true,
                            barrierColor: Colors.transparent,
                            ignoreAppBar: true,
                            withCloseControll: false,
                            elevation: 20,
                            useRootNavigator: true,
                            body: Container(
                              foregroundDecoration: BoxDecoration(
                                  color: Color.fromARGB(0, 2, 2, 2)),
                              padding: EdgeInsets.only(top: 100),
                              color: Color.fromARGB(255, 12, 120, 209),
                              child: const SideBar(),
                            ));
                      },
                      icon: const Icon(
                        Icons.menu,
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      DateFormat.yMMMd().format(DateTime.now()),
                      style: TextStyle(color: Colors.white38),
                    )
                  ],
                ),
                const Gap(35),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Favourites",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      const SizedBox(width: 19),
                      ElevatedButton(
                          onPressed: () =>
                              setState(() => isVisible = !isVisible),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            elevation: 0,
                            shadowColor: Colors.transparent,
                          ),
                          child: Text(isVisible ? "Close" : "Open"))
                    ]),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (isVisible)
                      if (fav_list.isNotEmpty)
                        Expanded(
                          child: SizedBox(
                            height: 250.0,
                            child: ReorderableGridView.extent(
                              maxCrossAxisExtent: 270,
                              onReorder: _onReorder,
                              childAspectRatio: 1.37,
                              shrinkWrap: true,
                              children: fav_list.map((ind) {
                                return Card(
                                  color: colors,
                                  borderOnForeground: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  elevation: 0,
                                  key: ValueKey(ind),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                        enlargeCenterPage: true,
                                        scrollDirection: Axis.horizontal,
                                        autoPlay: false,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _current = index;
                                          });
                                        }),
                                    items: fav_list.map((ind) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // _status = fav_list[ind].status;

                                                  InkWell(
                                                    onTap: () {
                                                      showModalBottomSheet<
                                                              void>(
                                                          context: (context),
                                                          enableDrag: true,
                                                          isScrollControlled:
                                                              true,
                                                          isDismissible: true,
                                                          // transitionAnimationController: controller,
                                                          shape:
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .vertical(
                                                              top: Radius
                                                                  .circular(20),
                                                            ),
                                                          ),
                                                          builder: (context) {
                                                            return ItemChartDetail(
                                                              item:
                                                                  ind.itemname,
                                                            );
                                                          });
                                                    },
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Icon(
                                                              Icons.dashboard,
                                                              color:
                                                                  Colors.black,
                                                              size: 10,
                                                            ),
                                                            Text(ind.itemname,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                            SizedBox(
                                                              width: 7,
                                                            ),
                                                            Text(
                                                              ind.last_update,
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                        Gap(3),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              ind.object_name,
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Gap(4),
                                                            Text(
                                                              '${ind.temp}°C',
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Gap(9),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: fav_list
                                                                  .asMap()
                                                                  .entries
                                                                  .map((entry) {
                                                                return GestureDetector(
                                                                  onTap: () =>
                                                                      _controller
                                                                          .animateToPage(
                                                                              entry.key),
                                                                  child:
                                                                      Container(
                                                                    width: 9.0,
                                                                    height: 9.0,
                                                                    margin: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            8.0,
                                                                        horizontal:
                                                                            4.0),
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black).withOpacity(_current ==
                                                                                entry.key
                                                                            ? 0.9
                                                                            : 0.4)),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                            ),
                                                            //_status = fav_list[0].status.toDouble();
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //   if (ind.status == 0)
                                                  //     Column(
                                                  //       mainAxisAlignment:
                                                  //           MainAxisAlignment
                                                  //               .start,
                                                  //       children: [
                                                  //         Text(
                                                  //           ind.itemname,
                                                  //           style: TextStyle(
                                                  //               color: Colors
                                                  //                   .white60),
                                                  //         ),
                                                  //         Gap(25),
                                                  //         Text(
                                                  //           'Alarm',
                                                  //           style: TextStyle(
                                                  //               fontSize: 20,
                                                  //               fontWeight:
                                                  //                   FontWeight
                                                  //                       .bold,
                                                  //               color:
                                                  //                   Colors.white),
                                                  //         ),
                                                  //       ],
                                                  //     ),
                                                  //   if (ind.status == 1)
                                                  //     Column(
                                                  //       mainAxisAlignment:
                                                  //           MainAxisAlignment
                                                  //               .start,
                                                  //       children: [
                                                  //         Text(
                                                  //           ind.itemname,
                                                  //           style: TextStyle(
                                                  //               color: Colors
                                                  //                   .white60),
                                                  //         ),
                                                  //         Gap(25),
                                                  //         Text(
                                                  //           'Ofline',
                                                  //           style: TextStyle(
                                                  //               fontSize: 20,
                                                  //               fontWeight:
                                                  //                   FontWeight
                                                  //                       .bold,
                                                  //               color:
                                                  //                   Colors.white),
                                                  //         )
                                                  //       ],
                                                  //     ),
                                                  //
                                                ]),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                  ],
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(width: 15),
                    Text(
                      "Check Status",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const Gap(7),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: ExpansionPanelList(
                    animationDuration: Duration(milliseconds: 1000),
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            leading: Image.asset(
                              'assets/images/Screenshot 2022-11-24 at 12.png',
                            ),
                            title: const Text(
                              'Rotgrupp',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          );
                        },

                        body: ListBody(children: [
                          Column(children: [
                            SizedBox(
                              height: 400,
                              child: FutureBuilder<List<Data>>(
                                future: DataProvider().getDatas(),
                                builder: (context, snapshot) {
                                  final data = snapshot.data;
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        itemCount: data!.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          final alldata = data[index];

                                          return Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: RoundedExpansionTile(
                                              leading: Image.asset(
                                                  'assets/images/blå.png'),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              title: Text(alldata.name),
                                              subtitle: isExpanded
                                                  ? Text("Alarm")
                                                  : null,
                                              children: [
                                                Row(children: const [
                                                  SizedBox(width: 200),
                                                  Text("Alarm"),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text("Favorite"),
                                                ]),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                        child: SizedBox(
                                                      height: 200,
                                                      child: FutureBuilder(
                                                          future: DefaultAssetBundle
                                                                  .of(context)
                                                              .loadString(
                                                                  'assets/loadjson/item_data.json'),
                                                          builder: (context,
                                                              snapshot) {
                                                            // var new_data = json.decode(
                                                            //     snapshot.data.toString());

                                                            // final Favourites
                                                            //     favlist =
                                                            //     Favourites(
                                                            //         alldata
                                                            //             .itam[
                                                            //                 index]
                                                            //             .itemName,
                                                            //         "8: 34 PM",
                                                            //         "Object A",
                                                            //         "11: 33 Pm",
                                                            //         23,
                                                            //         2);

                                                            // ignore: iterable_contains_unrelated_type
                                                            // fav_list.any((element) =>  element.itemname == alldata.itam[index].itemName);

                                                            // fav_list.forEach(
                                                            //   (element) {
                                                            //     if (element
                                                            //             .itemname
                                                            //             .trim() ==
                                                            //         alldata
                                                            //             .itam[
                                                            //                 index]
                                                            //             .itemName) {
                                                            //       isSaved =
                                                            //           true;
                                                            //     }
                                                            //   },
                                                            // );
                                                            // var isSaved = fav_list.firstWhere((element) =>element.itemname == alldata.itam[index].itemName);

                                                            var isSaved = false;

                                                            return ListView
                                                                .builder(
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return Card(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .stretch,
                                                                    children: [
                                                                      InkWell(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              isSaved = !isSaved;
                                                                              print(isSaved);
                                                                              if (fav_list.where((element) => element.itemname == alldata.itam[index].itemName).isNotEmpty) {
                                                                                fav_list.removeWhere((element) => element.itemname == alldata.itam[index].itemName);
                                                                                // if (isSaved) {
                                                                                //   ficon.remove(index);
                                                                                // }
                                                                              } else {
                                                                                var random = Random();
                                                                                var st = random.nextInt(3);
                                                                                fav_list.add(Favourites(alldata.itam[index].itemName, "8: 34 PM", "Object A", "11: 33 Pm", 23, st));
                                                                                // ficon.add(alldata.itam[index].itemName.trim());
                                                                                // _color = Colors.yellow;
                                                                                // _icon = Icons.star;
                                                                                // savedWords.add(alldata.itam[index].itemName);
                                                                                //await prefs.setString('item_name', alldata.itam[index].itemName);

                                                                                // _myfav.add(alldata.itam[index]);
                                                                                // savedWords = (alldata.itam[index] as List<Map<String, String>>).map((e) => e["url"]).toList();
                                                                              }

                                                                              // isSaved = !isSaved;
                                                                              //  fav_list.removeWhere((element) => element.itemname == fav_list[index].itemname);
                                                                            });
                                                                          },
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              const SizedBox(
                                                                                width: 20,
                                                                              ),
                                                                              const Icon(Icons.dashboard),
                                                                              const SizedBox(
                                                                                width: 20,
                                                                              ),
                                                                              Text(alldata.itam[index].itemName),
                                                                              const SizedBox(
                                                                                width: 110,
                                                                              ),
                                                                              Text(alldata.itam[index].alarm.toString()),
                                                                              const SizedBox(
                                                                                width: 30,
                                                                              ),
                                                                              IconButton(
                                                                                onPressed: () {},
                                                                                icon: Icon(
                                                                                  isSaved ? Icons.star : Icons.star_border,
                                                                                  color: isSaved ? Colors.amber : null,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                              itemCount: alldata
                                                                          .itam ==
                                                                      null
                                                                  ? 0
                                                                  : alldata.itam
                                                                      .length,
                                                            );
                                                          }),
                                                    ))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        });

                                    //return  Text("data!.length.toString()");
                                  }
                                  return const Text("Ther is no data");
                                },
                              ),
                            )
                          ])
                        ]),

                        // const Divider(height: 20),

                        isExpanded: _expanded,
                        canTapOnHeader: true,
                      ),
                    ],
                    dividerColor: Color.fromARGB(255, 12, 12, 12),
                    expansionCallback: (panelIndex, isExpanded) {
                      _expanded = !_expanded;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ]),
        ));
  }

  void getlength() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    length = (await _pref.getInt("length"))!;
  }

  void addobject() {
    for (int i = 0; i < 6; i++) {
      var random = Random();
      String it = random.toString();
      int st = random.nextInt(3);
      const _chars = 'ABCD';
      Random _rnd = Random();
      String getRandomString(int length) =>
          String.fromCharCodes(Iterable.generate(
              length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
      var onm = getRandomString(1);
      obj_list.add(
        Objects("Objct $onm", "01 01 2023 6:59 am", 25 - i, st),
      );
    }
    print("object");
  }

  void remove() {
    Favourites favourites;
    fav_list.remove(fav_list[0]);
  }
}

class Favourites {
  String itemname, hour, object_name, last_update;
  int temp, status;

  Favourites(this.itemname, this.hour, this.object_name, this.last_update,
      this.temp, this.status);

  Map<String, dynamic> toJson() {
    return {
      'itemname': itemname,
      'hour': hour,
      'object_name': object_name,
      'last_update': last_update,
      'temp': temp,
      'status': status,
    };
  }

  Favourites.fromJson(Map<String, dynamic> json)
      : itemname = json['itemname'],
        hour = json['hour'],
        object_name = json['object_name'],
        last_update = json['last_update'],
        temp = json['temp'],
        status = json['status'];
}

class Objects {
  String objectname, last_update;
  int temp, status;

  Objects(this.objectname, this.last_update, this.temp, this.status);

  Map<String, dynamic> toJson() {
    return {
      'objectname': objectname,
      'last_update': last_update,
      'temp': temp,
      'status': status,
    };
  }

  Objects.fromJson(Map<String, dynamic> json)
      : objectname = json['objectname'],
        last_update = json['last_update'],
        temp = json['temp'],
        status = json['status'];
}
