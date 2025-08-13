part of 'routes.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/auth');

  // Opsi A: async (paling simpel & aman)
  @override
  Future<bool> canActivate(String path, ModularRoute route) {
    return Modular.get<SessionApp>().hasValidSession();
  }
}

class LoggedOutGuard extends RouteGuard {
  // jika SUDAH login, cegah akses /auth dan arahkan ke dashboard
  LoggedOutGuard() : super(redirectTo: '/');

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final ok = await Modular.get<SessionApp>().hasValidSession();
    return !ok;
  }
}
