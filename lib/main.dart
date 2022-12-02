import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  // The root Widget of the App.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CH4 APP', //SHOWs on the phonescreen
      //set to false in order to deleted the red debug sign
      debugShowCheckedModeBanner: false,
      // This is the theme of your application.
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'CH4 APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;

  @override
  void initState() {
    chartData = getChartData();
    //shown data delayed by 1 sec.
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          title: const Text('CH4 Readings'),
        ),
        body: SfCartesianChart(
          backgroundColor: Colors.black,
          series: <LineSeries<LiveData, int>>[
            LineSeries<LiveData, int>(
              onRendererCreated: (ChartSeriesController controller) {
                _chartSeriesController = controller;
              },
              //data source, color, and x-y data assignment
              dataSource: chartData,
              color: Colors.white,
              xValueMapper: (LiveData reading, _) => reading.time,
              yValueMapper: (LiveData reading, _) => reading.data,
            )
          ],
          //x-axis grid view
          primaryXAxis: NumericAxis(
              //grid width
              majorGridLines: const MajorGridLines(width: 0),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              //interval
              interval: 1,
              //axis Title
              title: AxisTitle(text: 'Time (seconds)')),
          //y-axis grid view
          primaryYAxis: NumericAxis(
              axisLine: const AxisLine(width: 0),
              //Tick Lines
              majorTickLines: const MajorTickLines(size: 0),
              //axis Title
              title: AxisTitle(text: 'Data (unit)')),
        ),
      ),
    );
  }

  int time = 19;
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 20),
      LiveData(1, 20),
      LiveData(2, 20),
      LiveData(3, 50),
      LiveData(4, -10),
      LiveData(5, 30),
      LiveData(6, 10),
      LiveData(7, 20),
      LiveData(8, 20),
      LiveData(9, 20),
      LiveData(10, 53),
      LiveData(11, 72),
      LiveData(12, 86),
      LiveData(13, 52),
      LiveData(14, 94),
      LiveData(15, 92),
      LiveData(16, 86),
      LiveData(17, 72),
      LiveData(18, -10)
    ];
  }
}

class LiveData {
  LiveData(this.time, this.data);
  final int time; //must be an integer 'cause time (1,2,3,..)
  final num data; //can have a decimal point
}
