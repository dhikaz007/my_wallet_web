part of 'expenses_cubit.dart';

sealed class ExpensesState extends Equatable {
  const ExpensesState();

  @override
  List<Object?> get props => [];
}

final class ExpensesInitial extends ExpensesState {}

final class ExpensesLoading extends ExpensesState {}

final class ExpensesAddLoading extends ExpensesState {}

final class ExpensesAddSuccess extends ExpensesState {}

final class ExpensesDeleteSuccess extends ExpensesState {}

final class ExpensesEditSuccess extends ExpensesState {}

final class ExpensesLoaded extends ExpensesState {
  final List<ExpensesModel> tagihan;
  final double? sum;

  const ExpensesLoaded({required this.tagihan, this.sum});
  @override
  List<Object?> get props => [tagihan];
}

final class ExpensesFailed extends ExpensesState {
  final String err;

  const ExpensesFailed({required this.err});
  @override
  List<Object?> get props => [err];
}
