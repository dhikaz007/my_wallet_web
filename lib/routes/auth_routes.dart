part of 'routes.dart';

class AuthRoutes extends Module {
  @override
  void routes(r) {
    r.child('/', child: (_) => const LoginScreen());
  }
}
