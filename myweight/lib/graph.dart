import 'package:flutter/material.dart';
import 'login.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GraphPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _graph();
  }
}

class _graph extends State<GraphPage> {
  final List<BarChartModel> data = [
    BarChartModel(
      date: "1일",
      weight: 54,
      color: charts.ColorUtil.fromDartColor(Color(0xFF47505F)),
    ),
    BarChartModel(
      date: "8일",
      weight: 56,
      color: charts.ColorUtil.fromDartColor(Colors.red),
    ),
  ];

  void addData(String date1, double weight1, charts.Color color1) {
    BarChartModel a = new BarChartModel(
      date: date1,
      weight: weight1,
      color: color1,
    );
    data.add(a);
    return;
  }

  @override
  Widget build(BuildContext context) {
    print(currentUser.recentDate);

    addData("3일", 23.0, charts.ColorUtil.fromDartColor(Colors.red));

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("image/personal_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          // control focus
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: Column(children: [
            Container(
              child: BarChartGraph(
                data: data,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class BarChartModel {
  String title;
  String date;
  double weight;
  final charts.Color color;

  BarChartModel({
    this.title,
    this.date,
    this.weight,
    this.color,
  });
}

class BarChartGraph extends StatefulWidget {
  final List<BarChartModel> data;

  const BarChartGraph({Key key, this.data}) : super(key: key);

  @override
  _BarChartGraphState createState() => _BarChartGraphState();
}

class _BarChartGraphState extends State<BarChartGraph> {
  List<BarChartModel> _barChartList;

  @override
  void initState() {
    super.initState();
    _barChartList = [
      BarChartModel(title: "recent data"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
          id: "Financial",
          data: widget.data,
          domainFn: (BarChartModel series, _) => series.date,
          measureFn: (BarChartModel series, _) => series.weight,
          colorFn: (BarChartModel series, _) => series.color),
    ];

    return _buildFinancialList(series);
  }

  Widget _buildFinancialList(series) {
    return _barChartList != null
        ? ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => Divider(
              color: Colors.white,
              height: 5,
            ),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _barChartList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: MediaQuery.of(context).size.height / 2.3,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_barChartList[index].title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Expanded(child: charts.BarChart(series, animate: true)),
                  ],
                ),
              );
            },
          )
        : SizedBox();
  }
}
