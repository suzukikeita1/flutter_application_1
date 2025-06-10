import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/models/launch_point.dart';

class LaunchScatterScreen extends StatelessWidget {
  final List<LaunchPoint> data;
  const LaunchScatterScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final spots = data
        .map((e) => FlSpot(e.speed, e.angle))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('打球速度 × 打球角度 散布図')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ScatterChart(
          ScatterChartData(
            scatterSpots: spots
                .map((spot) => ScatterSpot(spot.x, spot.y))
                .toList(),
            minX: 60,
            maxX: 125,
            minY: -10,
            maxY: 60,
            borderData: FlBorderData(show: true),
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, interval: 10),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, interval: 10),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
          ),
        ),
      ),
    );
  }
}