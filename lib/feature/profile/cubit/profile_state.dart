part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final UserModel response;

  const ProfileLoaded({required this.response});
  @override
  List<Object?> get props => [response];
}

final class ProfileFailed extends ProfileState {
  final String err;

  const ProfileFailed({required this.err});
  @override
  List<Object?> get props => [err];
}
