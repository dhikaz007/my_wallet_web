part of 'routes.dart';

class HomeRoutes extends Module {
  @override
  void routes(r) {
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
          child: (_) => const ProfileMainScreen(),
          children: [
            ChildRoute('/database', child: (_) => const DatabaseScreen()),
          ],
        ),
      ],
    );
  }
}
