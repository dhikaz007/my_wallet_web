part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthLogout extends AuthState {}

final class AuthFailed extends AuthState {
  final String err;

  const AuthFailed({required this.err});
  @override
  List<Object?> get props => [err];
}
