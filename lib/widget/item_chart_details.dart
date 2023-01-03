// ignore_for_file: unnecessary_const

import 'dart:math';

import 'package:ethiostar_testing/widget/barchart.dart';
import 'package:charts_painter/chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import './scrollable_chart_screen.dart';
import '../screens/home_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ItemChartDetail extends StatefulWidget {
  final String item;

  ItemChartDetail({required this.item});

  @override
  State<ItemChartDetail> createState() => _ItemChartDetailState();
}

class _ItemChartDetailState extends State<ItemChartDetail>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 3, vsync: this);
  late String objectname = "Object A";
  late String last_updated = "4:39 PM";
  Color colors_ = Colors.white;
  Color card_colors = Colors.black;
  var _status;
  late List<ExpenseData> _chartData, _chm, _chh;
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  List<Objects> obj_list = [];
  @override
  void initState() {
    addobject();
    _chartData = getChartData();
    _chm = getChartDatam();
    _chh = getChartDatad();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(
      // Enables pinch zooming
      enablePinching: true,
      enableMouseWheelZooming: true,
      maximumZoomLevel: 0.3,
      zoomMode: ZoomMode.xy,
      enablePanning: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 215, 230, 241),
          borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: Radius.circular(20))),
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
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.dashboard,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.item,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(
                color: Colors.amber,
              ),
              Gap(10),
              Row(
                children: [SizedBox(width: 15), Text(objectname)],
              ),
              Gap(10),
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    controller: tabController,
                    isScrollable: false,
                    labelColor: Colors.white,
                    indicator: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        color: Color.fromARGB(255, 54, 83, 245)),
                    unselectedLabelColor: Color.fromARGB(255, 51, 50, 50),
                    tabs: const [
                      Tab(text: 'Hour'),
                      Tab(text: 'Day'),
                      Tab(text: 'Week'),
                    ],
                  ),
                ),
              ),
              Container(
                //padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    //         Chart(
                    //   state: ChartState<void>(
                    //     data: ChartData.fromList(
                    //       [1, 3, 4, 2, 7, 6, 2, 5, 4,1, 3, 4, 2, 7, 6, 2, 5, 4,1, 3, 4, 2, 7, 6, 2, 5, 4,1, 3, 4, 2, 7, 6, 2, 5, 4]
                    //           .map((e) => BarValue<void>(e.toDouble()))
                    //           .toList(),
                    //       axisMax: 8,
                    //     ),
                    //     itemOptions: BarItemOptions(
                    //       padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    //       barItemBuilder: (_) => BarItem(
                    //         color: Theme.of(context).accentColor,
                    //         radius: BorderRadius.vertical(top: Radius.circular(12.0)),
                    //       ),
                    //     ),
                    //     backgroundDecorations: [
                    //       GridDecoration(
                    //         verticalAxisStep: 1,
                    //         horizontalAxisStep: 4,
                    //         gridColor: Theme.of(context).dividerColor,
                    //       ),
                    //       SparkLineDecoration(
                    //         lineColor: Theme.of(context).accentColor,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SafeArea(
                      child: SfCartesianChart(
                        legend: Legend(
                          isVisible: false,
                        ),
                        zoomPanBehavior: _zoomPanBehavior,
                        tooltipBehavior: _tooltipBehavior,
                        series: <ChartSeries>[
                          StackedLineSeries<ExpenseData, String>(
                              dataSource: _chm,
                              xValueMapper: (ExpenseData exp, _) =>
                                  exp.expenseCategory,
                              yValueMapper: (ExpenseData exp, _) => exp.father,
                              name: 'Temprature',
                              markerSettings: MarkerSettings(
                                isVisible: true,
                              )),
                        ],
                        primaryXAxis: CategoryAxis(),
                      ),
                    ),
                    SafeArea(
                      child: SfCartesianChart(
                        legend: Legend(
                          isVisible: false,
                        ),
                        zoomPanBehavior: _zoomPanBehavior,
                        tooltipBehavior: _tooltipBehavior,
                        series: <ChartSeries>[
                          StackedLineSeries<ExpenseData, String>(
                              dataSource: _chh,
                              xValueMapper: (ExpenseData exp, _) =>
                                  exp.expenseCategory,
                              yValueMapper: (ExpenseData exp, _) => exp.son,
                              name: 'Temprature',
                              markerSettings: MarkerSettings(
                                isVisible: true,
                              )),
                        ],
                        primaryXAxis: CategoryAxis(),
                      ),
                    ),

                    SafeArea(
                      child: SfCartesianChart(
                        legend: Legend(
                          isVisible: false,
                        ),
                        zoomPanBehavior: _zoomPanBehavior,
                        tooltipBehavior: _tooltipBehavior,
                        series: <ChartSeries>[
                          StackedLineSeries<ExpenseData, String>(
                              dataSource: _chartData,
                              xValueMapper: (ExpenseData exp, _) =>
                                  exp.expenseCategory,
                              yValueMapper: (ExpenseData exp, _) => exp.mother,
                              name: 'Temprature',
                              markerSettings: MarkerSettings(
                                isVisible: true,
                              )),
                        ],
                        primaryXAxis: CategoryAxis(),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(10),
              Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "All States",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                ],
              ),
              Gap(9),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Last updated at: " + last_updated,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              ),
              Gap(9),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                    child: SizedBox(
                  height: 300,
                  child: Container(
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: obj_list.length,
                      itemBuilder: (ctx, i) {
                        if (obj_list[i].status == 0) {
                          colors_ = Colors.red;
                          card_colors = Color.fromARGB(255, 224, 219, 219).withOpacity(0.2);
                        } else if (obj_list[i].status == 1) {
                          colors_ = Color.fromARGB(255, 150, 147, 147);
                          card_colors =
                              Color.fromARGB(255, 247, 246, 243).withOpacity(0.2);
                        } else {
                          colors_ = Colors.white;
                          // card_colors =
                          //     Colors.grey.withOpacity(0.2);
                        }
                        return Card(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colors_,
                            ),
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      onobject_click(
                                          obj_list[i].objectname.trim(),
                                          obj_list[i].last_update.trim());
                                    });

                                    Navigator.pop(context, ItemChartDetail);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Gap(20),
                                      Text(
                                        obj_list[i].objectname,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Gap(10),
                                      Row(
                                        children: [
                                          Text(
                                            '${obj_list[i].temp}*C',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.15,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 5,
                      ),
                    ),
                  ),
                ))
              ])
            ],
          ),
        ],
      ),
    );
  }

  void onobject_click(String onmm, String last_updated) {
    objectname = onmm;
    last_updated = last_updated;
  }

  void addobject() {
    for (int i = 0; i < 4; i++) {
      var random = Random();
      String it = random.toString();
      int st = random.nextInt(3);
      const _chars = 'ABCD';
      Random _rnd = Random();
      String getRandomString(int length) =>
          String.fromCharCodes(Iterable.generate(
              length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
      var onm = getRandomString(1);
      if (onm == onm) {
        onm = getRandomString(1);
      }

      obj_list.add(
        Objects("Object $onm", "01 01 2023 6:59 am", 25 - i, st),
      );
    }
    print("object");
  }

  List<ExpenseData> getChartData() {
    final List<ExpenseData> chartData = [
      ExpenseData('Monday', 55, 40, 45, 48, 88, 99, 77, 55, 66, 88),
      ExpenseData('Tuseday', 33, 45, 54, 28, 88, 43, 33, 33, 22, 33),
      ExpenseData('Wendsday', 43, 23, 20, 34, 33, 44, 42, 22, 33, 44),
      ExpenseData('Thursday', 55, 40, 45, 48, 44, 33, 44, 33, 33, 44),
      ExpenseData('Friday', 33, 45, 54, 28, 33, 44, 33, 44, 33, 22),
      ExpenseData('Saturday', 43, 23, 20, 34, 33, 22, 11, 44, 55, 33),
      ExpenseData('Sunday', 55, 40, 45, 48, 33, 44, 53, 44, 33, 22),
    ];
    return chartData;
  }

  List<ExpenseData> getChartDatad() {
    final List<ExpenseData> chartData = [
      ExpenseData('01:00 Am', 22, 33, 34, 48, 88, 99, 77, 55, 66, 88),
      ExpenseData('02:05 Am', 23, 45, 54, 28, 88, 43, 33, 33, 22, 33),
      ExpenseData('03:10 Pm', 24, 23, 20, 34, 33, 44, 42, 22, 33, 44),
      ExpenseData('04:10 Am', 25, 40, 45, 48, 44, 33, 44, 33, 33, 44),
      ExpenseData('05:00 pm', 26, 45, 54, 28, 33, 44, 33, 44, 33, 22),
      ExpenseData('06:09 Am', 27, 23, 20, 34, 33, 22, 11, 44, 55, 33),
      ExpenseData('07:22 pm', 28, 40, 45, 48, 33, 44, 53, 44, 33, 22),
      ExpenseData('08:00 Am', 29, 40, 45, 48, 88, 99, 77, 55, 66, 88),
      ExpenseData('09:05 Am', 30, 45, 54, 28, 88, 43, 33, 33, 22, 33),
      ExpenseData('10:10 pm', 31, 23, 20, 34, 33, 44, 42, 22, 33, 44),
      ExpenseData('11:10 Am', 32, 40, 45, 48, 44, 33, 44, 33, 33, 44),
      ExpenseData('12:00 pm', 33, 45, 54, 28, 33, 44, 33, 44, 33, 22),
      ExpenseData('13:09 Am', 34, 23, 20, 34, 33, 22, 11, 44, 55, 33),
      ExpenseData('14:22 pm', 35, 40, 45, 48, 33, 44, 53, 44, 33, 22),
      ExpenseData('15:00 Am', 36, 40, 45, 48, 88, 99, 77, 55, 66, 88),
      ExpenseData('16:05 Am', 37, 45, 54, 28, 88, 43, 33, 33, 22, 33),
      ExpenseData('17:10 Pm', 38, 23, 20, 34, 33, 44, 42, 22, 33, 44),
      ExpenseData('18:10 Am', 39, 40, 45, 48, 44, 33, 44, 33, 33, 44),
      ExpenseData('19:00 pm', 40, 45, 54, 28, 33, 44, 33, 44, 33, 22),
      ExpenseData('20:09 Am', 41, 23, 20, 34, 33, 22, 11, 44, 55, 33),
      ExpenseData('21:22 pm', 42, 40, 45, 48, 33, 44, 53, 44, 33, 22),
    ];
    return chartData;
  }

  List<ExpenseData> getChartDatam() {
    final List<ExpenseData> chartData = [
      ExpenseData('01', 55, 40, 45, 48, 88, 99, 77, 55, 66, 88),
      ExpenseData('02', 33, 45, 54, 28, 88, 43, 33, 33, 22, 33),
      ExpenseData('03', 43, 23, 20, 34, 33, 44, 42, 22, 33, 44),
      ExpenseData('04', 55, 40, 45, 48, 44, 33, 44, 33, 33, 44),
      ExpenseData('05', 33, 45, 54, 28, 33, 44, 33, 44, 33, 22),
      ExpenseData('06', 43, 23, 20, 34, 33, 22, 11, 44, 55, 33),
      ExpenseData('07', 55, 40, 45, 48, 33, 44, 53, 44, 33, 22),
      ExpenseData('08', 55, 40, 45, 48, 88, 99, 77, 55, 66, 88),
      ExpenseData('09', 33, 45, 54, 28, 88, 43, 33, 33, 22, 33),
      ExpenseData('10', 43, 23, 20, 34, 33, 44, 42, 22, 33, 44),
      ExpenseData('11', 55, 40, 45, 48, 44, 33, 44, 33, 33, 44),
      ExpenseData('12', 33, 45, 54, 28, 33, 44, 33, 44, 33, 22),
      ExpenseData('13', 43, 23, 20, 34, 33, 22, 11, 44, 55, 33),
      ExpenseData('14', 55, 40, 45, 48, 33, 44, 53, 44, 33, 22),
      ExpenseData('15', 55, 40, 45, 48, 88, 99, 77, 55, 66, 88),
      ExpenseData('16', 33, 45, 54, 28, 88, 43, 33, 33, 22, 33),
      ExpenseData('17', 43, 23, 20, 34, 33, 44, 42, 22, 33, 44),
      ExpenseData('18', 55, 40, 45, 48, 44, 33, 44, 33, 33, 44),
      ExpenseData('19', 33, 45, 54, 28, 33, 44, 33, 44, 33, 22),
      ExpenseData('20', 43, 23, 20, 34, 33, 22, 11, 44, 55, 33),
      ExpenseData('21', 55, 40, 45, 48, 33, 44, 53, 44, 33, 22),
      ExpenseData('22', 55, 40, 45, 48, 33, 44, 53, 44, 33, 22),
      ExpenseData('23', 55, 40, 45, 48, 88, 99, 77, 55, 66, 88),
      ExpenseData('24', 33, 45, 54, 28, 88, 43, 33, 33, 22, 33),
      ExpenseData('25', 43, 23, 20, 34, 33, 44, 42, 22, 33, 44),
      // ExpenseData('26', 55, 40, 45, 48, 44, 33, 44, 33, 33, 44),
      // ExpenseData('27', 33, 45, 54, 28, 33, 44, 33, 44, 33, 22),
      // ExpenseData('28', 43, 23, 20, 34, 33, 22, 11, 44, 55, 33),
      // ExpenseData('29', 55, 40, 45, 48, 33, 44, 53, 44, 33, 22),
      // ExpenseData('30', 55, 40, 45, 48, 88, 99, 77, 55, 66, 88),
      // ExpenseData('31', 33, 45, 54, 28, 88, 43, 33, 33, 22, 33),
      // ExpenseData('32', 43, 23, 20, 34, 33, 44, 42, 22, 33, 44),
      // ExpenseData('33', 55, 40, 45, 48, 44, 33, 44, 33, 33, 44),
      // ExpenseData('34', 33, 45, 54, 28, 33, 44, 33, 44, 33, 22),
      // ExpenseData('35', 43, 23, 20, 34, 33, 22, 11, 44, 55, 33),
      // ExpenseData('36', 55, 40, 45, 48, 33, 44, 53, 44, 33, 22),
    ];
    return chartData;
  }
}

class ExpenseData {
  ExpenseData(this.expenseCategory, this.father, this.mother, this.son,
      this.daughter, this.n1, this.n2, this.n3, this.n4, this.n6, this.n7);
  final String expenseCategory;
  final num father;
  final num mother;
  final num son;
  final num daughter;
  final num n1;
  final num n2;
  final num n3;
  final num n4;
  final num n6;
  final num n7;
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
