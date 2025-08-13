import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../helpers/helpers.dart';
import '../../../storage/storage.dart';
import '../domain/services/services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final _authServices = AuthServices();

  void login({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      final response = await _authServices.fetchLogin(email, password);
      await StorageToken().setAccessToken(token: response.accessToken ?? '');
      SessionApp().setToken(response.accessToken);
      await StorageToken().setRefreshToken(token: response.refreshToken ?? '');
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailed(err: e.toString()));
    }
  }

  void logout() async {
    try {
      emit(AuthLoading());
      await _authServices.fetchLogout();
      await StorageToken().deleteAll();
      SessionApp().invalidate();
      emit(AuthLogout());
    } catch (e) {
      emit(AuthFailed(err: e.toString()));
    }
  }
}
