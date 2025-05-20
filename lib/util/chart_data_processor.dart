import 'package:pricetracker/data/model/gold_rate_entry.dart';

class ChartDataProcessor {
  final List<GoldRateEntry> entries;

  ChartDataProcessor(this.entries);

  double get minY {
    if (entries.isEmpty) return 0.0;
    final buyMin = entries
        .map((e) => e.buyRate)
        .reduce((a, b) => a < b ? a : b);
    final sellMin = entries
        .map((e) => e.sellRate)
        .reduce((a, b) => a < b ? a : b);
    return (buyMin < sellMin ? buyMin : sellMin) * 0.98;
  }

  double get maxY {
    if (entries.isEmpty) return 1.0;
    final buyMax = entries
        .map((e) => e.buyRate)
        .reduce((a, b) => a > b ? a : b);
    final sellMax = entries
        .map((e) => e.sellRate)
        .reduce((a, b) => a > b ? a : b);
    double max = (buyMax > sellMax ? buyMax : sellMax) * 1.02;
    if (max <= minY) max = minY + 10;
    return max;
  }

  double get leftTitleInterval {
    double interval = (maxY - minY) / 4;
    return interval == 0 ? 1.0 : interval;
  }

  double get bottomTitleInterval {
    double interval = (entries.length / 4).ceilToDouble();
    return interval == 0 ? 1.0 : interval;
  }
}
