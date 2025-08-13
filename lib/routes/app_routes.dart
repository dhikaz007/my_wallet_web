part of 'routes.dart';

class AppRoutes extends Module {
  @override
  void binds(i) {
    i.addSingleton<SessionApp>(SessionApp.new);
  }

  @override
  void routes(r) {
    r.child('/auth',
        child: (_) => const LoginScreen(), guards: [LoggedOutGuard()]);
    r.child(
      transition: TransitionType.noTransition,
      '/',
      child: (_) => const MainScreen(),
      guards: [AuthGuard()],
      children: [
        ChildRoute('/dashboard-expenses',
            child: (_) => const DashboardDailyScreen()),
        ChildRoute(
          '/expenses',
          child: (_) => const ExpensesMainScreen(),
          children: [
            ChildRoute('/daily', child: (_) => const ExpensesDailyScreen()),
            ChildRoute('/add-data', child: (_) => const AddExpensesScreen()),
            ChildRoute('/monthly', child: (_) => const ExpensesMonthlyScreen()),
          ],
        ),
        ChildRoute(
          '/profile',
          child: (_) => const ProfileScreen(),
          children: [
            // ChildRoute('/database', child: (_) => const DatabaseScreen()),
            // ChildRoute('/user', child: (_) => const ProfileScreen()),
          ],
        ),
      ],
    );
  }
}
