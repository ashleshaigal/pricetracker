import 'package:flutter/material.dart';
import 'package:pricetracker/util/strings.dart';
import 'package:pricetracker/viewmodel/gold_rate_viewmodel.dart';
import 'package:provider/provider.dart';

class SortFilter extends StatefulWidget {
  const SortFilter({super.key});

  @override
  State<SortFilter> createState() => _SortFilterState();
}

class _SortFilterState extends State<SortFilter> {
  String currentSort = AppStrings.sort;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<GoldRateViewModel>(context);

    return OutlinedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder:
              (context) => Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(AppStrings.selectSortOrder),
                    Divider(),
                    ListTile(
                      title: const Text(AppStrings.hightoLow),
                      onTap: () {
                        viewModel.sortByPriceDesc();
                        setState(() => currentSort = AppStrings.hightoLow);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text(AppStrings.lowtoHigh),
                      onTap: () {
                        viewModel.sortByPriceAsc();
                        setState(() => currentSort = AppStrings.lowtoHigh);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
        );
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        side: BorderSide(color: Colors.grey.shade700),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(currentSort, style: const TextStyle(color: Colors.black87)),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_drop_down, color: Colors.black87),
        ],
      ),
    );
  }
}
