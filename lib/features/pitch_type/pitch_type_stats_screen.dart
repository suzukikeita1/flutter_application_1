import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/providers/stat_provider.dart';
import '../../data/pitch_type_labels.dart';


class PitchTypeStatsScreen extends ConsumerWidget {
  const PitchTypeStatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(pitchTypeStatsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('球種別成績')),
      body: statsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラー: $e')),
        data: (stats) => ListView.separated(
          itemCount: stats.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final s = stats[index];
            final displayName = pitchTypeMap[s.pitchType] ?? s.pitchType;
            return ListTile(
              title: Text(displayName),
              subtitle: Text('打率: ${s.battingAvg.toStringAsFixed(3)}'),
              trailing: Text('${s.hits} / ${s.atBats}'),
            );
          },
        ),
      ),
    );
  }
}
