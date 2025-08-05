part of 'screens.dart';

class ExpensesDailyScreen extends StatefulWidget {
  const ExpensesDailyScreen({super.key});

  @override
  State<ExpensesDailyScreen> createState() => _ExpensesDailyScreenState();
}

class _ExpensesDailyScreenState extends State<ExpensesDailyScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Ada');
  final TextEditingController _dateController =
      TextEditingController(text: '2025-08-04');
  final TextEditingController _valueController =
      TextEditingController(text: '95000');
  final TextEditingController _typeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormState> _typeFormKey = GlobalKey();
  final GlobalKey<SfDataGridState> _pdfKey = GlobalKey();
  final ValueNotifier<bool> _showIndicator = ValueNotifier(false);
  DateTime? _initialDate;
  final DateRangePickerController _dateRangePickerController =
      DateRangePickerController();
  TypeModel? _selectedValue;

  @override
  void initState() {
    super.initState();
    context.read<ExpensesCubit>().getAllTagihan();
    context.read<TypeCubit>().getType();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _valueController.dispose();
    _dateRangePickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stateType = context.watch<TypeCubit>().state;

    return BackgroundApp(
      isScrollable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(8),
          Dialog(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonPrimary(
                label: 'Add Data',
                onPressed: () {
                  if (stateType is TypeLoaded) {
                    if (stateType.response.isNotEmpty) {
                      _addDataDialog(context);
                    } else {
                      ToastService.show(
                          type: SnackbarAppType.info,
                          msg: "Type still empty please add at least one data");
                    }
                  }
                },
              ),
              const Gap(12),
              ButtonPrimary(
                label: 'Add Type',
                onPressed: () {
                  _addTypeDialog(context);
                },
              ),
            ],
          ),
          const Gap(24),
          ButtonPrimary(
            label: 'Export to PDF',
            icon: SvgApp(
              width: 20,
              height: 20,
              asset: IconsApp.icPdf,
              color: ColorApp.white,
            ),
            onPressed: () => _exportPdf().then(
              (_) => ToastService.show(
                  type: SnackbarAppType.success,
                  msg: 'Data Berhasil di export'),
            ),
          ),
          const Gap(20),
          BlocConsumer<ExpensesCubit, ExpensesState>(
            listener: (context, state) async {
              if (state is ExpensesLoading || state is ExpensesAddLoading) {
                OverlayApp.showLoad(context);
              }
              if (state is! ExpensesLoading) {
                OverlayApp.hideLoad(context);
              }
              if (state is ExpensesAddSuccess ||
                  state is ExpensesDeleteSuccess ||
                  state is ExpensesEditSuccess) {
                context.read<ExpensesCubit>().getAllTagihan();
              }
            },
            builder: (context, state) {
              // print(state);
              if (state is ExpensesLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: ColorApp.primary),
                );
              }

              if (state is ExpensesLoaded) {
                if (state.tagihan.isEmpty) {
                  return const Center(
                    child: TextApp(text: 'Data Kosong'),
                  );
                }

                return SfDataGridTheme(
                  data: SfDataGridThemeData(
                    headerColor: ColorApp.primary.withAlpha(50),
                    gridLineColor: ColorApp.black,
                    gridLineStrokeWidth: 1.0,
                  ),
                  child: SfDataGrid(
                    key: _pdfKey,
                    source: TagihanDataSource(initialData: state.tagihan),
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    columnWidthMode: ColumnWidthMode.fill,
                    columnWidthCalculationRange:
                        ColumnWidthCalculationRange.visibleRows,
                    loadMoreViewBuilder: (context, loadMoreRows) =>
                        LoadMoreWidget(
                      loadMoreRows: loadMoreRows,
                      showIndicator: _showIndicator,
                      dataSource: TagihanDataSource(initialData: state.tagihan),
                    ),
                    columns: [
                      titleColumn('No', 'No', maxWidth: 60),
                      titleColumn('Created Date', 'Created Date'),
                      titleColumn('Type', 'Type'),
                      titleColumn('Name', 'Name'),
                      titleColumn('Price', 'Actual'),
                    ],
                    tableSummaryRows: [
                      GridTableSummaryRow(
                        color: Colors.grey.withAlpha(50),
                        showSummaryInRow: false,
                        title: 'Total',
                        titleColumnSpan: 4,
                        columns: [
                          const GridSummaryColumn(
                            name: 'Total',
                            columnName: 'Price',
                            summaryType: GridSummaryType.sum,
                          ),
                        ],
                        position: GridTableSummaryRowPosition.bottom,
                      ),
                    ],
                    allowSwiping: true,
                    endSwipeActionsBuilder: (context, dataGridRow, rowIndex) {
                      return Row(
                        children: [
                          Expanded(
                            child: AnimatedButton(
                              borderRadius: BorderRadius.circular(0),
                              icon: Icons.delete,
                              color: ColorApp.orange,
                              text: 'Edit',
                              pressEvent: () {},
                            ),
                          ),
                          Expanded(
                            child: AnimatedButton(
                              borderRadius: BorderRadius.circular(0),
                              icon: Icons.delete,
                              color: ColorApp.primary,
                              text: 'Delete',
                              pressEvent: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.question,
                                  title: 'Delete data ?',
                                  btnOkText: 'Yes',
                                  btnCancelText: 'No',
                                  btnCancelOnPress: () {
                                    setState(() {});
                                  },
                                  btnOkOnPress: () {
                                    final id = dataGridRow
                                        .getCells()
                                        .firstWhere(
                                            (cell) => cell.columnName == 'id')
                                        .value;
                                    context
                                        .read<ExpensesCubit>()
                                        .deleteTagihan(id);
                                  },
                                ).show();
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _exportPdf() async {
    PdfDocument document = _pdfKey.currentState!.exportToPdfDocument(
        fitAllColumnsInOnePage: true,
        cellExport: (DataGridCellPdfExportDetails details) {
          final currency = NumberFormat.currency(
            locale: 'id',
            symbol: 'Rp. ',
            decimalDigits: 0,
          );

          // 👉 FORMAT HEADER
          if (details.cellType == DataGridExportCellType.columnHeader) {
            details.pdfCell.style.backgroundBrush = PdfBrushes.maroon;
            details.pdfCell.style.textBrush = PdfBrushes.white;
          }

          // 👉 FORMAT ISI KOLOM
          if (details.cellType == DataGridExportCellType.row) {
            if (details.columnName == "Price") {
              final value = int.tryParse(details.pdfCell.value.toString()) ?? 0;
              details.pdfCell.value = currency.format(value);
            }
            if (details.columnName == "Created Date") {
              final value = DateTime.parse(details.pdfCell.value);
              details.pdfCell.value = value.getFullDate(format: 2);
            }
          }

          // 👉 FORMAT FOOTER SUMMARY (Total)
          if (details.cellType == DataGridExportCellType.tableSummaryRow) {
            if (details.columnName == "Price") {
              final value = int.tryParse(details.pdfCell.value
                      .toString()
                      .replaceAll(RegExp(r'[^\d]'), '')) ??
                  0;
              details.pdfCell.value = currency.format(value);
            }
            details.pdfCell.style.backgroundBrush =
                PdfSolidBrush(PdfColor(220, 220, 220));
          }
        },
        headerFooterExport: (details) {
          final double pageWidth = details.pdfPage.getClientSize().width;

          // Buat header
          final PdfPageTemplateElement header = PdfPageTemplateElement(
            Rect.fromLTWH(0, 0, pageWidth, 65),
          );

          // Definisikan font
          final font = PdfStandardFont(PdfFontFamily.timesRoman, 16,
              style: PdfFontStyle.bold);
          const String title = 'Expenses Daily';

          // Hitung ukuran teks
          final Size textSize = font.measureString(title);

          // Hitung posisi X agar teks berada di tengah
          final double xCenter = (pageWidth - textSize.width) / 2;

          // Gambar teks
          header.graphics.drawString(
            title,
            font,
            bounds: Rect.fromLTWH(xCenter, 25, textSize.width, textSize.height),
          );

          details.pdfDocumentTemplate.top = header;
        });

    final List<int> bytes = document.saveSync();
    await DataGridHelpers.saveAndLaunchFile(bytes, 'DataGrid.pdf');
    document.dispose();

    debugPrint("✅ Bytes saved, length: ${bytes.length}");
    debugPrint("✅ File saved");
  }

  Future<dynamic> _datePickerDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: ColorApp.white,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: SfDateRangePickerTheme(
            data: const SfDateRangePickerThemeData(
              selectionColor: ColorApp.primary,
              headerBackgroundColor: ColorApp.white,
            ),
            child: SfDateRangePicker(
              controller: _dateRangePickerController,
              backgroundColor: ColorApp.white,
              showNavigationArrow: true,
              initialSelectedDate: _initialDate,
              maxDate: DateTime.now(),
              headerStyle: const DateRangePickerHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: ColorApp.black,
                ),
              ),
              monthViewSettings: const DateRangePickerMonthViewSettings(
                enableSwipeSelection: false,
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorApp.grey,
                  ),
                ),
              ),
              showActionButtons: true,
              onCancel: () => Navigator.of(context).pop(),
              onSubmit: (value) {
                if (value is DateTime) {
                  _initialDate = _dateRangePickerController.selectedDate;
                  _dateController.text = _initialDate?.getFullDate() ?? '';
                }
                Navigator.of(context).pop();
                print("DATE $_initialDate");
              },
            ),
          ),
        ),
      ),
    );
  }

  GridColumn titleColumn(
    String name,
    String title, {
    double maxWidth = double.nan,
  }) {
    return GridColumn(
      columnName: name,
      maximumWidth: maxWidth,
      label: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        child: TextApp(
          text: title,
          size: FontAppSize.font_14,
          color: ColorApp.black,
          weight: FontAppWeight.bold,
        ),
      ),
    );
  }

  Future<dynamic> _addDataDialog(BuildContext context) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        clipBehavior: Clip.hardEdge,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: ColorApp.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextApp(
                    text: 'Tambah Pengeluaran',
                    size: FontAppSize.font_16,
                    color: ColorApp.primary,
                    weight: FontAppWeight.bold,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: ColorApp.black,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const Gap(20),
                      const TitleTextfieldWidget(label: 'Tanggal'),
                      const Gap(8),
                      TextFieldApp(
                        controller: _dateController,
                        hintText: '2025-08-04',
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Wajib diisi';
                          }
                          return null;
                        },
                        suffixIcon: InkWell(
                          onTap: () {
                            _datePickerDialog(context);
                          },
                          child: const Icon(
                            Icons.calendar_month,
                            color: ColorApp.grey,
                          ),
                        ),
                      ),
                      const Gap(12),
                      const TitleTextfieldWidget(label: 'Name'),
                      const Gap(8),
                      TextFieldApp(
                        controller: _nameController,
                        hintText: 'Beras',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Wajib di isi';
                          }
                          return null;
                        },
                      ),
                      const Gap(12),
                      const TitleTextfieldWidget(label: 'Aktual'),
                      const Gap(8),
                      TextFieldApp(
                        controller: _valueController,
                        hintText: '1.000.000',
                        digitOnly: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Wajib di isi';
                          }
                          return null;
                        },
                      ),
                      const Gap(12),
                      const TitleTextfieldWidget(label: 'Tipe'),
                      const Gap(8),
                      BlocBuilder<TypeCubit, TypeState>(
                        builder: (context, state) {
                          if (state is TypeLoading) {
                            return const ShimerApp(h: 40);
                          }

                          if (state is TypeFailed) {
                            return Center(
                              child: TextApp(
                                text: state.err,
                                size: FontAppSize.font_14,
                                color: ColorApp.black,
                                weight: FontAppWeight.medium,
                              ),
                            );
                          }
                          if (state is TypeLoaded) {
                            return DropdownButtonFormField(
                              value: _selectedValue,
                              validator: (value) {
                                if (value == null || value.label.isEmpty) {
                                  return 'Pilih salah satu kategori';
                                }
                                return null;
                              },
                              hint: const TextApp(text: 'Pilih Kategori'),
                              focusColor: ColorApp.transparent,
                              dropdownColor: ColorApp.white,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: ColorApp.primary),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                              ),
                              items: state.response
                                  .map(
                                    (e) => DropdownMenuItem<TypeModel>(
                                      value: e,
                                      child: TextApp(text: e.label),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value;
                                });
                              },
                            );
                          }
                          return const Center(
                            child: TextApp(
                              text: 'No Data',
                              size: FontAppSize.font_16,
                              weight: FontAppWeight.medium,
                            ),
                          );
                        },
                      ),
                      const Gap(20),
                      BlocListener<ExpensesCubit, ExpensesState>(
                        listener: (context, state) {
                          if (state is ExpensesAddSuccess) {
                            Navigator.pop(context);
                            _nameController.clear();
                            _dateController.clear();
                            _valueController.clear();
                            _selectedValue = null;
                          }
                        },
                        child: ButtonPrimary(
                          width: double.maxFinite,
                          height: 40,
                          label: 'Simpan',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final tagihan = ExpensesModel(
                                name: _nameController.text,
                                createdDate: _initialDate,
                                value: int.parse(
                                    _valueController.text.replaceAll('.', '')),
                                type: _selectedValue?.label ?? '',
                              );
                              context.read<ExpensesCubit>().addTagihan(tagihan);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _addTypeDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        // backgroundColor: ColorApp.white,
        clipBehavior: Clip.hardEdge,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextApp(
              text: 'Tambah Tipe',
              size: FontAppSize.font_16,
              color: ColorApp.primary,
              weight: FontAppWeight.bold,
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: ColorApp.black,
              ),
            ),
          ],
        ),
        content: Form(
          key: _typeFormKey,
          child: TextFieldApp(
            radius: 8,
            controller: _typeController,
            hintText: 'Bahan Makanan',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Wajib di isi';
              }
              return null;
            },
          ),
        ),
        actions: [
          BlocListener<TypeCubit, TypeState>(
            listener: (context, state) async {
              print(state);
              if (state is TypeAddSuccess) {
                _typeController.clear();
                ToastService.show(
                    type: SnackbarAppType.success, msg: 'Success add data');
                context.read<TypeCubit>().getType();
                Navigator.of(context).pop();
              }
            },
            child: ButtonPrimary(
              label: 'Submit',
              onPressed: () {
                if (_typeFormKey.currentState!.validate()) {
                  final type = TypeModel(
                      label: _typeController.text.capitalizeEachWord());
                  context.read<TypeCubit>().addType(type);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TagihanDataSource extends DataGridSource {
  List<DataGridRow> _dataGridRow = [];
  List<ExpensesModel> tagihanList = [];
  TagihanDataSource({required List<ExpensesModel> initialData}) {
    tagihanList = initialData;
    _buildDataGridRows();
  }

  void _buildDataGridRows() {
    _dataGridRow = tagihanList.map(
      (e) {
        return DataGridRow(
          cells: [
            DataGridCell<int>(columnName: 'No', value: e.id ?? 0),
            DataGridCell<DateTime>(
                columnName: 'Created Date', value: e.createdDate),
            DataGridCell<String>(columnName: 'Type', value: e.type),
            DataGridCell<String>(columnName: 'Name', value: e.name),
            DataGridCell<int>(columnName: 'Price', value: e.value),
          ],
        );
      },
    ).toList();
    notifyListeners();
  }

  void updateData(List<ExpensesModel> newList) {
    tagihanList = newList;
    _buildDataGridRows();
  }

  @override
  List<DataGridRow> get rows => _dataGridRow;

  void updateDataSource() {
    notifyListeners();
  }

  @override
  Widget? buildTableSummaryCellWidget(
    GridTableSummaryRow summaryRow,
    GridSummaryColumn? summaryColumn,
    RowColumnIndex rowColumnIndex,
    String summaryValue,
  ) {
    final currency = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    );

    if (summaryColumn == null) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: TextApp(
          text: summaryValue, // ini “Total:”
          size: FontAppSize.font_14,
          weight: FontAppWeight.bold,
        ),
      );
    }
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: TextApp(
        text: currency.format(int.parse(summaryValue)),
        size: FontAppSize.font_14,
        weight: FontAppWeight.bold,
      ),
    );
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final currency = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    );
    final indexStatic = effectiveRows.indexOf(row) + 1;

    return DataGridRowAdapter(
      cells: row.getCells().asMap().entries.map((entry) {
        final index = entry.key;
        final cellValue = entry.value.value;

        String displayText = cellValue.toString();

        if (index == 0) {
          displayText = indexStatic.toString();
        }

        if (index == 4) {
          displayText = currency.format(int.parse(cellValue.toString()));
        }

        if (index == 1) {
          displayText = (cellValue as DateTime).getFullDate(format: 2);
        }
        if (index == 2) {
          displayText = cellValue.toString();
        }

        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: TextApp(
            text: displayText,
            size: FontAppSize.font_14,
            color: ColorApp.black,
            maxLines: index == 2 ? 2 : 1,
            align: index == 2 ? TextAlign.center : TextAlign.left,
          ),
        );
      }).toList(),
    );
  }
}
