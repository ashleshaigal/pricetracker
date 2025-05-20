import 'gold_rate_entry.dart';

class GoldRateModel {
  final double rate;
  final double growPrice;
  final double? growPercentage;
  final List<GoldRateEntry> goldSilverRates;

  GoldRateModel({
    required this.rate,
    required this.growPrice,
    required this.growPercentage,
    required this.goldSilverRates,
  });

  factory GoldRateModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final list = (data['goldSilverRate'] as List)
        .map((e) => GoldRateEntry.fromJson(e))
        .toList();
    return GoldRateModel(
      rate: (data['rate'] as num).toDouble(),
      growPrice: (data['grow_price'] as num).toDouble(),
      growPercentage: data['grow_percentage'] != null
          ? (data['grow_percentage'] as num).toDouble()
          : null,
      goldSilverRates: list,
    );
  }
}
