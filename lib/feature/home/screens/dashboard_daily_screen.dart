part of 'screens.dart';

class DashboardDailyScreen extends StatelessWidget {
  const DashboardDailyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextApp(text: 'Dashboard Daily'),
      ],
    );
  }
}
