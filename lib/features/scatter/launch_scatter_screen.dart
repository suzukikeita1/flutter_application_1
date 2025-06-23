import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/models/launch_point.dart';

class LaunchScatterScreen extends StatelessWidget {
  final List<LaunchPoint> data;
  const LaunchScatterScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final scatterSpots = data.map((e) {
      final isHardHit = e.speed >= 110;
      return ScatterSpot(
        e.speed,
        e.angle,
        radius: isHardHit ? 6 : 4,
        color: isHardHit ? Colors.redAccent : Colors.blueAccent,
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('打球速度 × 打球角度 散布図')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ScatterChart(
          ScatterChartData(
            scatterSpots: scatterSpots,
            minX: 60,
            maxX: 125,
            minY: -10,
            maxY: 60,
            borderData: FlBorderData(show: true),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: true,
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 10,
                  getTitlesWidget: (value, _) =>
                      Text('${value.toStringAsFixed(0)}°', style: const TextStyle(fontSize: 10)),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 10,
                  getTitlesWidget: (value, _) =>
                      Text('${value.toStringAsFixed(0)} mph', style: const TextStyle(fontSize: 10)),
                ),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            scatterTouchData: ScatterTouchData(
              enabled: true,
              touchTooltipData: ScatterTouchTooltipData(
                tooltipBgColor: Colors.black87,
                getTooltipItems: (ScatterSpot touchedSpot) {
                    return ScatterTooltipItem(
                        'Speed: ${touchedSpot.x.toStringAsFixed(1)} mph\n'
                        'Angle: ${touchedSpot.y.toStringAsFixed(1)}°',
                        textStyle: const TextStyle(color: Colors.white, fontSize: 12),
                      );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
