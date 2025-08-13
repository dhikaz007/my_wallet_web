part of 'shared.dart';

class RouteBreadcrumb extends StatefulWidget {
  const RouteBreadcrumb({super.key});

  @override
  State<RouteBreadcrumb> createState() => _RouteBreadcrumbState();
}

class _RouteBreadcrumbState extends State<RouteBreadcrumb> {
  final Map<String, String> _labelMap = const {
    '': 'Home',
    'dashboard-expenses': 'Dashboard Expenses',
    'expenses': 'Expenses',
    'daily': 'Daily',
    'add-data': 'Add Data',
    'monthly': 'Monthly',
    'profile': 'Profile',
    'database': 'Database',
    'user': 'User',
  };

  late VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _listener = () => setState(() {});
    Modular.to.addListener(_listener);
  }

  @override
  void dispose() {
    Modular.to.removeListener(_listener);
    super.dispose();
  }

  /// Mapping route induk ke default child supaya nggak blank
  String _normalizeRoute(String route) {
    switch (route) {
      case '/':
        return '/dashboard-expenses';
      case '/expenses':
        return '/expenses/daily';
      case '/profile':
        return '/profile/database';
      default:
        return route;
    }
  }

  @override
  Widget build(BuildContext context) {
    final path = Modular.to.path; // contoh: /expenses/daily
    final segments = path.split('/').where((s) => s.isNotEmpty).toList();

    // gabung path step-by-step untuk navigasi onTap
    final routes = <String>['/']; // home dulu
    String acc = '';
    for (final seg in segments) {
      acc += '/$seg';
      routes.add(acc);
    }

    return BreadCrumb.builder(
      itemCount: routes.length,
      builder: (index) {
        final route = routes[index];
        final label = _labelMap[route.split('/').last] ?? _labelMap['']!;
        final isLast = index == routes.length - 1;

        return BreadCrumbItem(
          content: TextApp(
            text: label,
            size: FontAppSize.font_14,
            weight: index == routes.length - 1
                ? FontAppWeight.bold
                : FontAppWeight.normal,
          ),
          onTap:
              isLast ? null : () => Modular.to.navigate(_normalizeRoute(route)),
        );
      },
      divider: const Icon(Icons.chevron_right, size: 18),
    );
  }
}
