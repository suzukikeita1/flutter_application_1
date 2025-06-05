import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/models/monthly_stat.dart';

class MonthlyOpsScreen extends StatelessWidget {
  final List<MonthlyStat> data;
  const MonthlyOpsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> spots = data
        .map((e) => FlSpot(e.month.toDouble(), e.ops))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('月別OPS')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            minX: data.first.month.toDouble(),
            maxX: data.last.month.toDouble(),
            minY: 0.0,
            maxY: 1.2,
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, _) => Text('${value.toInt()}月'),
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 0.2,
                  getTitlesWidget: (value, _) => Text(value.toStringAsFixed(1)),
                ),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                spots: spots,
                barWidth: 3,
                dotData: FlDotData(show: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
