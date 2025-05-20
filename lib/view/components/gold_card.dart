import 'package:flutter/material.dart';
import 'package:pricetracker/util/strings.dart';
import 'package:pricetracker/viewmodel/gold_rate_viewmodel.dart';
import '../../data/model/gold_rate_entry.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GoldCard extends StatelessWidget {
  final GoldRateEntry entry;
  const GoldCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMM dd, yyyy').format(entry.date);
    final viewModel = Provider.of<GoldRateViewModel>(context, listen: false);

    Color iconColor;
    if (viewModel.metalType == AppStrings.goldValue) {
      iconColor = const Color(0xFFFFD700);
    } else if (viewModel.metalType == AppStrings.silverValue) {
      iconColor = const Color(0xFFC0C0C0);
    } else {
      iconColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.diamond, color: iconColor, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        viewModel.metalType == AppStrings.goldValue
                            ? AppStrings.gold
                            : AppStrings.silver,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formattedDate,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${AppStrings.buy}${entry.buyRate.toStringAsFixed(2)}${AppStrings.gram}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${AppStrings.sell}${entry.sellRate.toStringAsFixed(2)}${AppStrings.gram}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
