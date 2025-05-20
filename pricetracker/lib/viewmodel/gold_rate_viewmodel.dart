import 'package:flutter/material.dart';
import 'package:pricetracker/util/chart_data_processor.dart';
import '../data/model/gold_rate_entry.dart';
import '../data/service/gold_rate_service.dart';

class GoldRateViewModel extends ChangeNotifier {
  final IGoldRateService _goldRateService;

  GoldRateViewModel(this._goldRateService);

  String _metalType = 'gold';
  int _days = 365;
  List<GoldRateEntry> _entries = [];
  bool isLoading = false;
  String? errorMessage;

  List<GoldRateEntry> get entries => _entries;
  String get metalType => _metalType;
  int get days => _days;
  ChartDataProcessor get chartData => ChartDataProcessor(entries);

  Future<void> fetchGoldRates() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final data = await _goldRateService.fetchGoldRates(_metalType, _days);
      _entries = data.result.goldSilverRates;
    } catch (e) {
      _entries = [];
      errorMessage = 'Failed to load data';
    }

    isLoading = false;
    notifyListeners();
  }

  void setMetalType(String type) {
    _metalType = type;
    fetchGoldRates();
  }

  void setDays(int newDays) {
    _days = newDays != 0 ? newDays + 1 : newDays;
    fetchGoldRates();
  }

  void sortByPriceAsc() {
    _entries.sort((a, b) => a.sellRate.compareTo(b.sellRate));
    notifyListeners();
  }

  void sortByPriceDesc() {
    _entries.sort((a, b) => b.sellRate.compareTo(a.sellRate));
    notifyListeners();
  }
}
