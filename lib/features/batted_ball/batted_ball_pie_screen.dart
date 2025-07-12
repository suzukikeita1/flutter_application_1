import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/providers/stat_provider.dart';

class BattedBallPieScreen extends ConsumerWidget {
  const BattedBallPieScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final battedAsync = ref.watch(battedBallRatioProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('打球傾向（円グラフ）')),
      body: battedAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラー: $e')),
        data: (ratios) {
          final entries = ratios.entries.toList();
          final total = ratios.values.reduce((a, b) => a + b);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: entries.asMap().entries.map((entry) {
                        final index = entry.key;
                        final label = entry.value.key;
                        final value = entry.value.value;
                        final percent = (value / total * 100).toStringAsFixed(1);
                        final colors = [
                          Colors.brown[300],
                          Colors.green[400],
                          Colors.blue[400],
                          Colors.orange[400]
                        ];
                        return PieChartSectionData(
                          value: value,
                          title: '$label\n$percent%',
                          radius: 80,
                          titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
                          color: colors[index % colors.length],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('※ 打球タイプの割合（2024年）'),
              ],
            ),
          );
        },
      ),
    );
  }
}