import 'package:flutter/material.dart';
import 'date_range_filter.dart';
import 'metal_type_filter.dart';
import 'sort_filter.dart';

class FilterButtons extends StatelessWidget {
  final bool showSortFilter;

  const FilterButtons({
    super.key,
    this.showSortFilter = true, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const DateRangeFilter(),
          const MetalTypeFilter(),
          if (showSortFilter) const SortFilter(),
        ],
      ),
    );
  }
}
