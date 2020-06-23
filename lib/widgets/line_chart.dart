import 'package:cov_scanner/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cov_scanner/constants.dart';
class LineReportChart extends StatelessWidget {
  final String title;
  LineReportChart(this.title);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.2,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: getSports(),
              isCurved: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              colors: [kPrimaryColor],
              barWidth: 4,
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> getSports() {
    double i=0.0;
    List<FlSpot>x=[];

    for(var ii in corona_corona.corona_data){
      x.add(
          FlSpot(
              i,
              ii.get_me(title)*1.0
          ));
      i++;
    }
  //   print(x.length);
   //  print(x[0]);
    return x;
  }
}