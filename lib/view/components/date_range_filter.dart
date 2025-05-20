import 'package:flutter/material.dart';
import 'package:pricetracker/util/strings.dart';
import 'package:pricetracker/viewmodel/gold_rate_viewmodel.dart';
import 'package:provider/provider.dart';

class DateRangeFilter extends StatelessWidget {
  const DateRangeFilter({super.key});

  void _showCustomRangeSlider(
    BuildContext context,
    GoldRateViewModel viewModel,
  ) {
    double sliderValue = viewModel.days.toDouble();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    AppStrings.dateRange,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    value: sliderValue,
                    min: 1,
                    max: 365,
                    divisions: 364,
                    label: sliderValue.round().toString(),
                    onChanged:
                        (value) => setModalState(() => sliderValue = value),
                    onChangeEnd: (value) {
                      viewModel.setDays(value.toInt());
                      Navigator.pop(context);
                    },
                  ),
                  Text('${sliderValue.toInt()} ${AppStrings.daysSelected}'),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<GoldRateViewModel>(context);

    void showDateRangeOptions() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppStrings.selectDateRange),
                  Divider(),
                  ListTile(
                    title: const Text(AppStrings.last7Days),
                    onTap: () {
                      viewModel.setDays(7);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(AppStrings.last30Days),
                    onTap: () {
                      viewModel.setDays(30);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(AppStrings.last365Days),
                    onTap: () {
                      viewModel.setDays(365);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(AppStrings.custom),
                    onTap: () {
                      Navigator.pop(context);
                      _showCustomRangeSlider(context, viewModel);
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      );
    }

    return OutlinedButton(
      onPressed: showDateRangeOptions,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        side: BorderSide(color: Colors.grey.shade700),
      ),
      child: Text(
        viewModel.days == 7
            ? AppStrings.last7Days
            : viewModel.days == 30
            ? AppStrings.last30Days
            : viewModel.days == 365
            ? AppStrings.last365Days
            : '${AppStrings.custom} (${viewModel.days} Days)',
        style: const TextStyle(color: Colors.black87),
      ),
    );
  }
}
