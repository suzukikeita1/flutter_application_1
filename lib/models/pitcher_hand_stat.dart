// データモデルの定義

class PitcherHandStat {
  final String pThrows; // 'L' or 'R'
  final double battingAvg;

  PitcherHandStat({
    required this.pThrows,
    required this.battingAvg,
  });

  factory PitcherHandStat.fromJson(Map<String, dynamic> json) {
    return PitcherHandStat(
      pThrows: json['p_throws'] as String,
      battingAvg: (json['batting_avg'] as num).toDouble(),
    );
  }
}