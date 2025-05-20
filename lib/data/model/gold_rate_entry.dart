class GoldRateEntry {
  final DateTime date;
  final double buyRate;
  final double sellRate;

  GoldRateEntry({
    required this.date,
    required this.buyRate,
    required this.sellRate,
  });

  factory GoldRateEntry.fromJson(Map<String, dynamic> json) {
    return GoldRateEntry(
      date: DateTime.parse(json['todays_date']),
      buyRate: (json['buy_rate'] as num).toDouble(),
      sellRate: (json['sell_rate'] as num).toDouble(),
    );
  }
}
