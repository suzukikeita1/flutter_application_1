import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/zone_cell.dart';

class ZoneHeatmapScreen extends StatelessWidget {
  final List<ZoneCell> data;
  const ZoneHeatmapScreen({super.key, required this.data});

  Color getColor(double value) {
    if (value == 0.0) return Colors.grey.shade200;
    final red = (255 * value).clamp(0, 255).toInt();
    return Color.fromARGB(255, red, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    const newGridSize = 5; // 新しいグリッドサイズ
    final cellSize = MediaQuery.of(context).size.width / (newGridSize + 2); // 中央寄せ

    // 10×10のデータを5×5に縮小
    final matrix = List.generate(newGridSize, (_) => List.filled(newGridSize, 0.0));
    for (var cell in data) {
      final newX = cell.x ~/ 2; // x座標を2で割って縮小
      final newZ = cell.z ~/ 2; // z座標を2で割って縮小
      if (newX >= 0 && newX < newGridSize && newZ >= 0 && newZ < newGridSize) {
        matrix[newZ][newX] += cell.avg; // 被っている部分を足し合わせる
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('ゾーン別打率ヒートマップ')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(newGridSize, (z) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(newGridSize, (x) {
                final value = matrix[z][x];
                final isStrikeZone = x >= 1 && x <= 3 && z >= 1 && z <= 3; // ストライクゾーンの範囲
                return Container(
                  width: cellSize,
                  height: cellSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: getColor(value),
                    border: Border.all(
                      color: isStrikeZone ? Colors.blueAccent : Colors.black12, // ストライクゾーンの枠を青色に
                      width: isStrikeZone ? 2 : 1, // ストライクゾーンの枠を太くする
                    ),
                  ),
                  child: Text(
                    value > 0 ? value.toStringAsFixed(3) : '',
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}