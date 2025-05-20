import 'package:flutter/material.dart';
import 'package:pricetracker/util/strings.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../viewmodel/gold_rate_viewmodel.dart';
import 'package:intl/intl.dart';
import 'components/filter_buttons.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<GoldRateViewModel>(context);
    final processor = viewModel.chartData;
    final entries = viewModel.entries;

    double minY = processor.minY;
    double maxY = processor.maxY;
    double leftTitleInterval = processor.leftTitleInterval;
    double bottomTitleInterval = processor.bottomTitleInterval;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F6F1),
        elevation: 0,
        title: Text(
          '${viewModel.metalType == AppStrings.goldValue ? AppStrings.gold : AppStrings.silver} ${AppStrings.priceTrends}',
          style: const TextStyle(
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
              child: const FilterButtons(showSortFilter: false),
            ),

            Expanded(
              child:
                  viewModel.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : entries.isEmpty
                      ? const Center(
                        child: Text(
                          AppStrings.noData,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      )
                      : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16.0,
                            8.0,
                            16.0,
                            16.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.only(
                              top: 20,
                              right: 20,
                              left: 10,
                              bottom: 10,
                            ),
                            child: AspectRatio(
                              aspectRatio: 1.5,
                              child: LineChart(
                                LineChartData(
                                  lineTouchData: LineTouchData(
                                    enabled: true,
                                    touchCallback: (
                                      FlTouchEvent event,
                                      LineTouchResponse? touchResponse,
                                    ) {
                                      setState(() {
                                        if (event.isInterestedForInteractions &&
                                            touchResponse != null &&
                                            touchResponse.lineBarSpots !=
                                                null &&
                                            touchResponse
                                                .lineBarSpots!
                                                .isNotEmpty) {
                                        } else {}
                                      });
                                    },
                                    touchTooltipData: LineTouchTooltipData(
                                      getTooltipItems: (
                                        List<LineBarSpot> touchedSpots,
                                      ) {
                                        return touchedSpots.map((
                                          LineBarSpot touchedSpot,
                                        ) {
                                          final int index =
                                              touchedSpot.spotIndex;
                                          if (index < 0 ||
                                              index >= entries.length) {
                                            return null;
                                          }
                                          final date = entries[index].date;
                                          final buyRate =
                                              entries[index].buyRate;
                                          final sellRate =
                                              entries[index].sellRate;

                                          String text;
                                          if (touchedSpot.barIndex == 0) {
                                            text =
                                                '${AppStrings.buy}${buyRate.toStringAsFixed(2)}';
                                          } else {
                                            text =
                                                '${AppStrings.sell}${sellRate.toStringAsFixed(2)}';
                                          }

                                          return LineTooltipItem(
                                            '$text\n${DateFormat('dd MMM yy').format(date)}',
                                            TextStyle(
                                              color:
                                                  touchedSpot.barIndex == 0
                                                      ? Colors.amberAccent
                                                      : Colors.lightBlueAccent,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          );
                                        }).toList();
                                      },
                                    ),
                                    getTouchedSpotIndicator: (
                                      LineChartBarData barData,
                                      List<int> spotIndexes,
                                    ) {
                                      return spotIndexes.map((spotIndex) {
                                        return TouchedSpotIndicatorData(
                                          FlLine(
                                            color: Colors.grey,
                                            strokeWidth: 1,
                                          ),
                                          FlDotData(
                                            getDotPainter: (
                                              spot,
                                              percent,
                                              barData,
                                              index,
                                            ) {
                                              return FlDotCirclePainter(
                                                radius: 4,

                                                strokeWidth: 2,
                                                strokeColor: Colors.white,
                                              );
                                            },
                                          ),
                                        );
                                      }).toList();
                                    },
                                  ),

                                  gridData: FlGridData(
                                    show: true,
                                    drawVerticalLine: true,
                                    getDrawingHorizontalLine: (value) {
                                      return const FlLine(
                                        color: Colors.grey,
                                        strokeWidth: 0.5,
                                        dashArray: [5, 5],
                                      );
                                    },
                                    getDrawingVerticalLine: (value) {
                                      return const FlLine(
                                        color: Colors.grey,
                                        strokeWidth: 0.5,
                                        dashArray: [5, 5],
                                      );
                                    },
                                  ),

                                  titlesData: FlTitlesData(
                                    show: true,
                                    rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    topTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 32,
                                        interval: bottomTitleInterval,
                                        getTitlesWidget: (
                                          double value,
                                          TitleMeta meta,
                                        ) {
                                          if (value.toInt() < 0 ||
                                              value.toInt() >= entries.length) {
                                            return const Text('');
                                          }
                                          final date =
                                              entries[value.toInt()].date;
                                          String text;
                                          if (entries.length > 7) {
                                            text = DateFormat(
                                              'MMM yy',
                                            ).format(date);
                                          } else {
                                            text = DateFormat(
                                              'dd MMM',
                                            ).format(date);
                                          }
                                          return SideTitleWidget(
                                            meta: meta,
                                            space: 8.0,
                                            child: Text(
                                              text,
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 40,
                                        interval: leftTitleInterval,
                                        getTitlesWidget: (
                                          double value,
                                          TitleMeta meta,
                                        ) {
                                          bool isMinOrMax =
                                              (value == minY || value == maxY);
                                          bool isNearInterval = false;
                                          if (leftTitleInterval > 0) {
                                            final double numIntervals =
                                                (maxY - minY) /
                                                leftTitleInterval;
                                            for (
                                              int i = 0;
                                              i <= numIntervals.ceil();
                                              i++
                                            ) {
                                              double targetValue =
                                                  minY +
                                                  (leftTitleInterval * i);
                                              if ((value - targetValue).abs() <
                                                  (leftTitleInterval * 0.1)) {
                                                isNearInterval = true;
                                                break;
                                              }
                                            }
                                          }

                                          if (isMinOrMax || isNearInterval) {
                                            return SideTitleWidget(
                                              meta: meta,
                                              space: 8.0,
                                              child: Text(
                                                value.toInt().toString(),
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            );
                                          }
                                          return const Text('');
                                        },
                                      ),
                                    ),
                                  ),

                                  borderData: FlBorderData(
                                    show: true,
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                  ),

                                  lineBarsData: [
                                    LineChartBarData(
                                      spots:
                                          entries
                                              .asMap()
                                              .entries
                                              .map(
                                                (e) => FlSpot(
                                                  e.key.toDouble(),
                                                  e.value.buyRate,
                                                ),
                                              )
                                              .toList(),
                                      isCurved: true,
                                      color: Colors.amber,
                                      barWidth: 2,
                                      isStrokeCapRound: true,
                                      dotData: const FlDotData(show: false),
                                      belowBarData: BarAreaData(show: false),
                                    ),
                                    LineChartBarData(
                                      spots:
                                          entries
                                              .asMap()
                                              .entries
                                              .map(
                                                (e) => FlSpot(
                                                  e.key.toDouble(),
                                                  e.value.sellRate,
                                                ),
                                              )
                                              .toList(),
                                      isCurved: true,
                                      color: Colors.blueAccent,
                                      barWidth: 2,
                                      isStrokeCapRound: true,
                                      dotData: const FlDotData(show: false),
                                      belowBarData: BarAreaData(show: false),
                                    ),
                                  ],

                                  minX: 0,
                                  maxX:
                                      (entries.isNotEmpty
                                              ? entries.length - 1
                                              : 0)
                                          .toDouble(),
                                  minY: minY,
                                  maxY: maxY,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem(Colors.amber, AppStrings.buyRate),
                  const SizedBox(width: 30),
                  _buildLegendItem(Colors.blueAccent, AppStrings.sellRate),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
