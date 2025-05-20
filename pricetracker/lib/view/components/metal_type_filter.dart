import 'package:flutter/material.dart';
import 'package:pricetracker/viewmodel/gold_rate_viewmodel.dart';
import 'package:provider/provider.dart';

class MetalTypeFilter extends StatelessWidget {
  const MetalTypeFilter({super.key});

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
                    Text('Select Metal Type'),
                    Divider(),
                    ListTile(
                      title: const Text('Gold'),
                      onTap: () {
                        viewModel.setMetalType('gold');
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Silver'),
                      onTap: () {
                        viewModel.setMetalType('silver');
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
      child: Text(
        viewModel.metalType[0].toUpperCase() + viewModel.metalType.substring(1),
        style: const TextStyle(color: Colors.black87),
      ),
    );
  }
}
