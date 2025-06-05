import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_1/features/ops/monthly_ops_screen.dart';
import 'package:flutter_application_1/providers/stat_provider.dart';

// 初期メニュー画面
class AnalysisMenuScreen extends ConsumerWidget {
  const AnalysisMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(monthlyStatsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Shohei Ohtani 分析メニュー')),
      body: statsAsync.when(
        data: (data) => ListView(
          children: [
            ListTile(
              title: const Text('📈 月別OPSを見る'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MonthlyOpsScreen(data: data),
                ),
              ),
            ),
            const Divider(),
            const ListTile(title: Text('📊 打球速度×角度（後日追加）')),
            const ListTile(title: Text('🧊 ゾーン打率（後日追加）')),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラーが発生しました: $e')),
      ),
    );
  }
}