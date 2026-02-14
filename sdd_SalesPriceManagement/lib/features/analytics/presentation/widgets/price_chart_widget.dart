import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../../price/presentation/providers/price_provider.dart';

/// 価格推移グラフWidget
class PriceChartWidget extends ConsumerWidget {
  const PriceChartWidget({
    super.key,
    required this.productId,
    required this.period,
    this.storeId,
  });

  final int productId;
  final PricePeriod period;
  final int? storeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(priceRecordsByPeriodProvider(productId, period));

    return recordsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('エラー: $error')),
      data: (allRecords) {
        // 店舗フィルタ
        final records = storeId != null
            ? allRecords.where((r) => r.storeId == storeId).toList()
            : allRecords;

        if (records.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.show_chart,
                  size: 48,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(height: 8),
                Text(
                  'この期間のデータがありません',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          );
        }

        // データをソート
        records.sort((a, b) => a.purchaseDate.compareTo(b.purchaseDate));

        // グラフデータを作成
        final spots = <FlSpot>[];
        for (var i = 0; i < records.length; i++) {
          spots.add(FlSpot(i.toDouble(), records[i].price.toDouble()));
        }

        // 最小値・最大値を計算
        final prices = records.map((r) => r.price).toList();
        final minPrice = prices.reduce((a, b) => a < b ? a : b);
        final maxPrice = prices.reduce((a, b) => a > b ? a : b);
        final priceRange = (maxPrice - minPrice).toDouble();
        final yMin = (minPrice.toDouble() - priceRange * 0.1).clamp(0.0, double.infinity);
        final yMax = maxPrice.toDouble() + priceRange * 0.1;

        final priceFormat = NumberFormat('#,###');
        final dateFormat = DateFormat('M/d');

        return Padding(
          padding: const EdgeInsets.only(right: 16, top: 16),
          child: LineChart(
            LineChartData(
              minY: yMin,
              maxY: yMax == yMin ? yMax + 100 : yMax,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: priceRange > 0 ? priceRange / 4 : 50,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        '¥${priceFormat.format(value.toInt())}',
                        style: Theme.of(context).textTheme.labelSmall,
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 24,
                    interval: records.length > 7 ? (records.length / 4).ceilToDouble() : 1,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < 0 || index >= records.length) {
                        return const SizedBox.shrink();
                      }
                      return Text(
                        dateFormat.format(records[index].purchaseDate),
                        style: Theme.of(context).textTheme.labelSmall,
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  curveSmoothness: 0.3,
                  color: Theme.of(context).colorScheme.primary,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: records.length <= 10,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 4,
                        color: Theme.of(context).colorScheme.primary,
                        strokeWidth: 2,
                        strokeColor: Theme.of(context).colorScheme.surface,
                      );
                    },
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  ),
                ),
              ],
              lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (touchedSpot) => Theme.of(context).colorScheme.inverseSurface,
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      final index = spot.spotIndex;
                      final record = records[index];
                      return LineTooltipItem(
                        '¥${priceFormat.format(record.price)}\n${dateFormat.format(record.purchaseDate)}',
                        TextStyle(
                          color: Theme.of(context).colorScheme.onInverseSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
