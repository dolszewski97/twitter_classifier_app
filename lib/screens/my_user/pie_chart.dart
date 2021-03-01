import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:twitter_classifier_app/datatypes/analise_stats.dart';
import 'package:twitter_classifier_app/filter_notifier.dart';

// ignore: must_be_immutable
class PieChartStats extends StatefulWidget {
  final AnaliseStats analiseStats;
  int touchedIndex = -1;
  FilterNotifier notifier = FilterNotifier();

  PieChartStats(this.analiseStats);
  @override
  _PieChartStatsState createState() => _PieChartStatsState();
}

class _PieChartStatsState extends State<PieChartStats> with ChangeNotifier {
  @override
  void dispose() {
    super.dispose();
  }

  //Build method for analise stats pie chart
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.1,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(PieChartData(
              pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                setState(() {
                  widget.touchedIndex = pieTouchResponse.touchedSectionIndex;
                  if (pieTouchResponse.touchInput is FlPanEnd) {
                    widget.touchedIndex = -1;
                  } else {
                    widget.touchedIndex = pieTouchResponse.touchedSectionIndex;
                  }
                });
              }),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 10,
              centerSpaceRadius: 80,
              sections: chartSections(),
            ))),
      ),
    );
  }

  //List of chart sections
  List<PieChartSectionData> chartSections() {
    return List.generate(3, (i) {
      final isTouched = i == widget.touchedIndex;
      //Size up section when pressed
      final double fontSize = isTouched ? 20 : 16;
      final double radius = isTouched ? 90 : 80;
      final double badgeSize = isTouched ? 40 : 30;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.lightGreen,
            value: double.parse(widget.analiseStats.positive.toString()),
            title: widget.analiseStats.posP() + "%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            badgeWidget: Badge(
              badgeContent:
                  Image.asset('assets/images/smile.png', height: badgeSize),
              badgeColor: Colors.lightGreen,
            ),
            // badgeWidget: Badge(
            //   Icon(Icons.add),
            //   widgetSize,
            //   Colors.lightGreen,
            // ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.redAccent,
            value: double.parse(widget.analiseStats.negative.toString()),
            title: widget.analiseStats.negP() + "%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            badgeWidget: Badge(
              badgeContent:
                  Image.asset('assets/images/angry.png', height: badgeSize),
              badgeColor: Colors.redAccent,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.grey,
            value: double.parse(widget.analiseStats.neutral.toString()),
            title: widget.analiseStats.neuP() + "%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            badgeWidget: Badge(
              badgeContent:
                  Image.asset('assets/images/normal.png', height: badgeSize),
              //Icon(Icons.remove, size: widgetSize, color: Colors.black),
              badgeColor: Colors.grey,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          return null;
      }
    });
  }
}
