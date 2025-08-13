import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/models/models.dart';
import '../domain/services/services.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final _profileServices = ProfileServices();

  void getUser() async {
    try {
      emit(ProfileLoading());
      final response = await _profileServices.fetchUser();
      emit(ProfileLoaded(response: response));
    } catch (e) {
      emit(ProfileFailed(err: e.toString()));
    }
  }
}
