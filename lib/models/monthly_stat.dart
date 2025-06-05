// データモデルの定義
class MonthlyStat {
  final int month;
  final double ops;

  MonthlyStat({required this.month, required this.ops});

  factory MonthlyStat.fromJson(Map<String, dynamic> json) {
    return MonthlyStat(
      month: json['month'],
      ops: (json['OPS'] as num).toDouble(),
    );
  }
}