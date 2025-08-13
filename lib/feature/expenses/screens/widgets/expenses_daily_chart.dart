part of 'widgets.dart';

class ExpensesDailyChart extends StatelessWidget {
  final List<ExpensesModel> dataSource;
  final TooltipBehavior tooltipBehavior;
  const ExpensesDailyChart(
      {super.key, required this.dataSource, required this.tooltipBehavior});

  @override
  Widget build(BuildContext context) {
    final totalValue = dataSource.fold<int>(0, (sum, item) => sum + item.value);
    final percentFormat = NumberFormat.decimalPercentPattern(decimalDigits: 1);

    return SfCircularChart(
      legend: const Legend(isVisible: true),
      title: const ChartTitle(text: 'Expenses'),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        builder: (data, point, series, pointIndex, seriesIndex) {
          final datas = data as ExpensesModel;
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: ColorApp.black.withOpacity(.25),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  datas.name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: ColorApp.black,
                  ),
                ),
                const Gap(8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorApp.primary,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      NumberFormat('#,##0.###', 'id').format(datas.value),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      series: [
        DoughnutSeries<ExpensesModel, String>(
          dataSource: dataSource,
          xValueMapper: (datum, index) => datum.name,
          yValueMapper: (datum, index) => datum.value,
          dataLabelMapper: (datum, index) {
            final percentage = datum.value.toDouble() / totalValue.toDouble();
            return percentFormat.format(percentage);
          },
          legendIconType: LegendIconType.circle,
          dataLabelSettings: const DataLabelSettings(
            margin: EdgeInsets.zero,
            isVisible: true,
            labelPosition: ChartDataLabelPosition.outside,
            // labelIntersectAction: _labelIntersectAction,
          ),
        ),
      ],
    );
  }
}
