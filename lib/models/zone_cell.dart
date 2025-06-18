// データモデル: ゾーンセル
class ZoneCell {
  final int x;
  final int z;
  final double avg;

  ZoneCell({required this.x, required this.z, required this.avg});

  factory ZoneCell.fromJson(Map<String, dynamic> json) {
    return ZoneCell(
      x: json['zone_x'],
      z: json['zone_z'],
      avg: (json['batting_avg'] as num).toDouble(),
    );
  }
}