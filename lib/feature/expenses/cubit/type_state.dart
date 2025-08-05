part of 'type_cubit.dart';

sealed class TypeState extends Equatable {
  const TypeState();

  @override
  List<Object?> get props => [];
}

final class TypeInitial extends TypeState {}

final class TypeLoading extends TypeState {}

final class TypeLoaded extends TypeState {
  final List<TypeModel> response;

  const TypeLoaded({required this.response});
  @override
  List<Object?> get props => [response];
}

final class TypeAddSuccess extends TypeState {}

final class TypeRemoveSuccess extends TypeState {}

final class TypeFailed extends TypeState {
  final String err;

  const TypeFailed({required this.err});
  @override
  List<Object?> get props => [err];
}
