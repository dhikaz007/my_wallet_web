import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../db/db.dart';
import '../../../db/models/models.dart';

part 'type_state.dart';

class TypeCubit extends Cubit<TypeState> {
  TypeCubit() : super(TypeInitial());

  void getType() async {
    try {
      emit(TypeLoading());
      final response = await DatabaseTypeExpanses.fetchType();
      emit(TypeLoaded(response: response));
    } catch (e) {
      emit(TypeFailed(err: e.toString()));
    }
  }

  void addType(TypeModel type) async {
    try {
      emit(TypeLoading());
      await DatabaseTypeExpanses.insertType(type);
      emit(TypeAddSuccess());
    } catch (e) {
      emit(TypeFailed(err: e.toString()));
    }
  }

  void deleteType(int id) async {
    try {
      emit(TypeLoading());
      await DatabaseTypeExpanses.deleteType(id);
      emit(TypeRemoveSuccess());
    } catch (e) {
      emit(TypeFailed(err: e.toString()));
    }
  }
}
