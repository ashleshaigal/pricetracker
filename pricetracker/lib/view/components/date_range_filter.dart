import 'package:flutter/material.dart';
import 'package:pricetracker/viewmodel/gold_rate_viewmodel.dart';
import 'package:provider/provider.dart';

class DateRangeFilter extends StatelessWidget {
  const DateRangeFilter({super.key});

  // Function to show the custom range slider bottom sheet
  void _showCustomRangeSlider(
    BuildContext context,
    GoldRateViewModel viewModel,
  ) {
    double sliderValue =
        viewModel.days.toDouble(); // Initialize with current days

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
                    'Select Custom Date Range (Days)',
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
                      Navigator.pop(context); // Close the slider bottom sheet
                    },
                  ),
                  Text('${sliderValue.toInt()} days selected'),
                  const SizedBox(height: 20), // Add some spacing
                  ElevatedButton(
                    onPressed: () {
                      viewModel.setDays(sliderValue.toInt());
                      Navigator.pop(context); // Close the slider bottom sheet
                    },
                    child: const Text('Apply'),
                  ),
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

    // Function to show the main date range selection bottom sheet (fixed options)
    void showDateRangeOptions() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select Date Range'),
                  Divider(),
                  ListTile(
                    title: const Text('Last 7 Days'),
                    onTap: () {
                      viewModel.setDays(7);
                      Navigator.pop(context); // Close the options bottom sheet
                    },
                  ),
                  ListTile(
                    title: const Text('Last 30 Days'),
                    onTap: () {
                      viewModel.setDays(30);
                      Navigator.pop(context); // Close the options bottom sheet
                    },
                  ),
                  ListTile(
                    title: const Text('Last 365 Days'),
                    onTap: () {
                      viewModel.setDays(365);
                      Navigator.pop(context); // Close the options bottom sheet
                    },
                  ),
                  ListTile(
                    title: const Text('Custom'),
                    onTap: () {
                      Navigator.pop(
                        context,
                      ); // Close the options bottom sheet first
                      _showCustomRangeSlider(
                        context,
                        viewModel,
                      ); // Then show the slider
                    },
                  ),
                  const SizedBox(height: 10), // Add some bottom padding
                ],
              ),
            ),
          );
        },
      );
    }

    return OutlinedButton(
      onPressed:
          showDateRangeOptions, // Call the function to show the options list
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        side: BorderSide(color: Colors.grey.shade700),
      ),
      child: Text(
        viewModel.days == 7
            ? 'Last 7 Days'
            : viewModel.days == 30
            ? 'Last 30 Days'
            : viewModel.days == 365
            ? 'Last 365 Days'
            : 'Custom (${viewModel.days} Days)', // Indicate custom selected days
        style: const TextStyle(color: Colors.black87),
      ),
    );
  }
}
