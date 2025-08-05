import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../db/db.dart';
import '../../../db/models/models.dart';

part 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit() : super(ExpensesInitial());

  final int limit = 5;
  int offset = 0;
  final List<ExpensesModel> _allTagihan = [];
  bool hasMoreData = true;
  List<ExpensesModel> get currentList => List.unmodifiable(_allTagihan);

  void getAllTagihan() async {
    try {
      emit(ExpensesLoading());
      await Future.delayed(const Duration(milliseconds: 800));
      offset = 0;
      hasMoreData = true;
      _allTagihan.clear();
      final response =
          await DatabaseBill.getAllTagihan(offset: offset, limit: limit);
      _allTagihan.addAll(response);
      offset += response.length;
      hasMoreData = response.length == limit;
      emit(ExpensesLoaded(tagihan: response));
    } catch (e) {
      emit(ExpensesFailed(err: e.toString()));
    }
  }

  Future<void> loadMoreTagihan() async {
    if (!hasMoreData) return;
    try {
      final data =
          await DatabaseBill.getAllTagihan(offset: offset, limit: limit);
      if (data.isNotEmpty) {
        _allTagihan.addAll(data);
        offset += data.length;
        if (data.length < limit) hasMoreData = false;

        emit(ExpensesLoaded(tagihan: currentList));
      } else {
        hasMoreData = false;
      }
    } catch (e) {
      emit(ExpensesFailed(err: e.toString()));
    }
  }

  void addTagihan(ExpensesModel tagihan) async {
    try {
      emit(ExpensesAddLoading());
      await Future.delayed(const Duration(milliseconds: 800));
      await DatabaseBill.insertTagihan(tagihan);
      emit(ExpensesAddSuccess());
    } catch (e) {
      emit(ExpensesFailed(err: e.toString()));
    }
  }

  void deleteTagihan(int id) async {
    try {
      emit(ExpensesAddLoading());
      await Future.delayed(const Duration(milliseconds: 800));
      await DatabaseBill.deleteTagihan(id);
      emit(ExpensesDeleteSuccess());
    } catch (e) {
      emit(ExpensesFailed(err: e.toString()));
    }
  }

  void editTagihan(ExpensesModel tagihan) async {
    try {
      emit(ExpensesAddLoading());
      await Future.delayed(const Duration(milliseconds: 800));
      await DatabaseBill.updateTagihan(tagihan);
      emit(ExpensesEditSuccess());
    } catch (e) {
      emit(ExpensesFailed(err: e.toString()));
    }
  }

  void clearAllTagihan() async {
    try {
      emit(ExpensesAddLoading());
      await Future.delayed(const Duration(milliseconds: 800));
      await DatabaseBill.deleteAllTagihan();
      await DatabaseTypeExpanses.deleteDatabase();
      emit(ExpensesDeleteSuccess());
    } catch (e) {
      emit(ExpensesFailed(err: e.toString()));
    }
  }

  void getTagihanByType(TagihanType type) async {
    try {
      emit(ExpensesLoading());
      await Future.delayed(const Duration(milliseconds: 800));
      final response = await DatabaseBill.getByType(type: type);
      double total = response.fold(0, (prev, item) {
        return prev + item.value;
      });
      emit(ExpensesLoaded(tagihan: response, sum: total));
    } catch (e) {
      emit(ExpensesFailed(err: e.toString()));
    }
  }
}
