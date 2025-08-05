part of 'routes.dart';

class HomeRoutes extends Module {
  @override
  void routes(r) {
    r.child(
      '/',
      child: (_) => const MainScreen(),
      children: [
        ChildRoute('/profile',
            child: (_) => const ProfileScreen()), // /profile → Profile
      ],
    );
  }
}
