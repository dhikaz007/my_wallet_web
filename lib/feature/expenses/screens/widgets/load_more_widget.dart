part of 'widgets.dart';

class LoadMoreWidget extends StatelessWidget {
  final LoadMoreRows loadMoreRows;
  final ValueListenable<bool> showIndicator;
  final TagihanDataSource dataSource;
  const LoadMoreWidget({
    super.key,
    required this.loadMoreRows,
    required this.showIndicator,
    required this.dataSource,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: showIndicator,
      builder: (context, value, child) {
        final tagihanCubit = context.watch<ExpensesCubit>();

        // Sembunyikan tombol jika tidak ada data lagi
        if (!tagihanCubit.hasMoreData) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.maxFinite,
          color: Colors.grey.withAlpha(200),
          child: Container(
            height: 40,
            alignment: Alignment.center,
            child: ButtonPrimaryText(
              label: value ? 'Loading...' : 'Load More',
              onPressed: value
                  ? null
                  : () async {
                      value = true;

                      await tagihanCubit.loadMoreTagihan();
                      dataSource.updateData(tagihanCubit.currentList);

                      value = false;
                      loadMoreRows(); // Panggil untuk trigger refresh data grid
                    },
            ),
          ),
        );
      },
    );
  }
}
