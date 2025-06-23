import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/providers/stat_provider.dart';

class LrBattingChartScreen extends ConsumerWidget {
  const LrBattingChartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lrStatsAsync = ref.watch(lrBattingStatsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('投手左右別 打率')),
      body: lrStatsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラー: $e')),
        data: (stats) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceEvenly,
                maxY: 0.4,
                barGroups: stats.asMap().entries.map((entry) {
                  final index = entry.key;
                  final stat = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: stat.battingAvg,
                        width: 30,
                        color: stat.pThrows == 'L' ? Colors.redAccent : Colors.blueAccent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                    showingTooltipIndicators: [0],
                  );
                }).toList(),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        if (value.toInt() >= stats.length) return const SizedBox();
                        final label = stats[value.toInt()].pThrows == 'L' ? '左投' : '右投';
                        return Text(label, style: const TextStyle(fontSize: 12));
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 0.05,
                      getTitlesWidget: (value, _) =>
                          Text(value.toStringAsFixed(2), style: const TextStyle(fontSize: 10)),
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(show: true, horizontalInterval: 0.05),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.black87,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final label = stats[group.x.toInt()].pThrows == 'L' ? '左投' : '右投';
                      return BarTooltipItem(
                        '$label\n打率: ${rod.toY.toStringAsFixed(3)}',
                        const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}