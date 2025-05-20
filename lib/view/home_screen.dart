import 'package:flutter/material.dart';
import 'package:pricetracker/util/strings.dart';
import 'package:provider/provider.dart';
import '../viewmodel/gold_rate_viewmodel.dart';
import 'components/gold_card.dart';
import 'components/filter_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<GoldRateViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F6F1),
        elevation: 0,
        title: const Text(
          AppStrings.title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false, 
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: const Color(0xFFF9F6F1),
              child: const FilterButtons(),
            ),

            Expanded(
             
              child:
                  viewModel.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : viewModel.entries.isEmpty
                      ? const Center(
                        child: Text(
                          AppStrings.noData,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ), 
                        itemCount: viewModel.entries.length,
                        itemBuilder: (context, index) {
                          final entry = viewModel.entries[index];
                          return GoldCard(entry: entry);
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
