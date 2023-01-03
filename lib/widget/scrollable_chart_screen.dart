import 'dart:math';

import 'package:charts_painter/chart.dart';
import './chart_options.dart';
import './toggle_item.dart';
import 'package:flutter/material.dart';

class ScrollableChartScreen extends StatefulWidget {
  ScrollableChartScreen({Key? key}) : super(key: key);

  @override
  _ScrollableChartScreenState createState() => _ScrollableChartScreenState();
}

class _ScrollableChartScreenState extends State<ScrollableChartScreen> {
  List<double> _values = <double>[
    17,
    18,
    46,
    22,
    22,
    23,
    20,
    49,
    17,
    15,
    16,
    20,
  ];
  List<String> horizontal = ["Mon", "Tue", "Wend", "Thur", "Fri", "Sat", "Sun"];
  var my_data = OrdinalSales("1222", 23);
  double targetMax = 0;
  bool _showValues = true;
  bool _smoothPoints = false;
  bool _showBars = true;
  bool _isScrollable = true;
  bool _fixedAxis = false;
  int minItems = 20;
  int? _selected;

  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    // _updateValues();
  }

  // void _updateValues() {
  //   final Random _rand = Random();
  //   final double _difference = _rand.nextDouble() * 15;

  //   targetMax = 3 +
  //       ((_rand.nextDouble() * _difference * 0.75) - (_difference * 0.25))
  //           .roundToDouble();
  //   _values.addAll(List.generate(minItems, (index) {
  //     return 2 + _rand.nextDouble() * _difference;
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    final targetArea = TargetAreaDecoration(
      targetMax: 30,
      targetMin: 20,
      colorOverTarget: Color.fromARGB(255, 11, 210, 236),

      // targetAreaFillColor: Theme.of(context).colorScheme.error.withOpacity(0.2),
      targetLineColor: Colors.white,

      // targetAreaRadius: BorderRadius.circular(12.0),
    );

    final _chartState = ChartState(

      data: ChartData(
        // my_data.year.map((e) => BarValue<void>(e)).toList(),
        axisMax: 20,
        axisMin: 18,
        [
           [3, 5, 7, 9, 4, 3, 6].map((e) => ChartItem<void>(e.toDouble())).toList(),

        ]
      ),
      itemOptions: BarItemOptions(
        padding: EdgeInsets.symmetric(horizontal: _isScrollable ? 12.0 : 2.0),
        minBarWidth: _isScrollable ? 36.0 : 4.0,
        barItemBuilder: (data) {
          return BarItem(
            color: targetArea.getTargetItemColor(
                Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(_showBars ? 1.0 : 0.0),
                data.item),
            radius: const BorderRadius.vertical(
              top: Radius.circular(10.0),
              bottom: Radius.circular(10.0),
            ),
          );
        },
      ),
      behaviour: ChartBehaviour(
        isScrollable: _isScrollable,
        onItemClicked: (item) {
          setState(() {
            _selected = item.itemIndex;
          });
        },
      ),
      backgroundDecorations: [
        HorizontalAxisDecoration(
          endWithChart: false,
          showTopValue: true,

          lineWidth: 2.0,
          axisStep: 2,
          lineColor:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
        ),
        // // VerticalAxisDecoration(
        // //   endWithChart: false,
        // //   lineWidth: 2.0,
        // //   axisStep: 7,
        // //   lineColor:
        // //       Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
        // // ),
        GridDecoration(
            showVerticalGrid: false,
            showHorizontalValues: _fixedAxis ? false : _showValues,
            showVerticalValues: _fixedAxis ? true : _showValues,
            verticalValuesPadding: const EdgeInsets.symmetric(vertical: 12.0),
            verticalAxisStep: 1,
            horizontalAxisStep: 7,
            textStyle: Theme.of(context).textTheme.caption,
            gridColor: Colors.transparent),
        targetArea,
        SparkLineDecoration(
          fill: true,
          lineColor: Theme.of(context)
              .primaryColor
              .withOpacity(!_showBars ? 0.2 : 0.0),
          smoothPoints: _smoothPoints,
        ),
      ],
      foregroundDecorations: [
        ValueDecoration(
          alignment: _showBars ? Alignment.bottomCenter : Alignment(0.0, -1.0),
          textStyle: Theme.of(context).textTheme.button!.copyWith(
              color: (_showBars
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.primary)
                  .withOpacity(_isScrollable ? 1.0 : 0.0)),
        ),
        SparkLineDecoration(
          lineWidth: 2.0,
          lineColor: Colors.black.withOpacity(!_showBars ? 1.0 : 0.0),
          smoothPoints: _smoothPoints,
        ),
        // // BorderDecoration(
        //   endWithChart: true,
        //   color: Theme.of(context).colorScheme.primaryContainer,
        // ),
        SelectedItemDecoration(
          _selected,
          animate: true,
          selectedColor: Theme.of(context).colorScheme.secondary,
          topMargin: 40.0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                shape: BoxShape.circle,
              ),
              child: Text(
                  '${_selected != null ? _values[_selected!].toStringAsPrecision(2) : '...'}'),
            ),
          ),
          backgroundColor: Theme.of(context)
              .scaffoldBackgroundColor
              .withOpacity(_isScrollable ? 0.5 : 0.8),
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 4, 128, 115),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: _isScrollable
                        ? ScrollPhysics()
                        : NeverScrollableScrollPhysics(),
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    child: AnimatedChart(
                      duration: Duration(milliseconds: 450),
                      width: MediaQuery.of(context).size.width - 24.0,
                      height: MediaQuery.of(context).size.height * 0.4,
                      state: _chartState,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 350),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Colors.white,
                          Colors.white.withOpacity(0.0),
                        ],
                        stops: [
                          0.5,
                          1.0
                        ]),
                  ),
                  width: _fixedAxis ? 34.0 : 0.0,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: DecorationsRenderer(
                    _fixedAxis
                        ? [
                            HorizontalAxisDecoration(
                              asFixedDecoration: true,
                              lineWidth: 1.0,
                              axisStep: 1,
                              showValues: true,
                              endWithChart: false,
                              axisValue: (value) => '$horizontal E',
                              legendFontStyle:
                                  Theme.of(context).textTheme.caption,
                              valuesAlign: TextAlign.center,
                              valuesPadding: const EdgeInsets.only(right: 8.0),
                              lineColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer
                                  .withOpacity(0.8),
                            )
                          ]
                        : [],
                    _chartState,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
