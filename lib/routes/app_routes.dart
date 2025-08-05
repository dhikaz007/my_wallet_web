part of 'routes.dart';

class AppRoutes extends Module {
  @override
  void routes(r) {
    r.child(
      transition: TransitionType.noTransition,
      '/',
      child: (_) => const MainScreen(),
      children: [
        ChildRoute('/dashboard-expenses',
            child: (_) => const DashboardDailyScreen()),
        ChildRoute(
          '/expenses',
          child: (_) => const ExpensesMainScreen(),
          children: [
            ChildRoute('/daily', child: (_) => const ExpensesDailyScreen()),
            ChildRoute('/monthly', child: (_) => const ExpensesMonthlyScreen()),
          ],
        ),
        ChildRoute(
          '/profile',
          child: (_) => const ProfileMainScreen(),
          children: [
            ChildRoute('/database', child: (_) => const DatabaseScreen()),
          ],
        ),
      ],
    );
  }
}
