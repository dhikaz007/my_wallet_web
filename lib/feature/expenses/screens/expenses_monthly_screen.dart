part of 'screens.dart';

class ExpensesMonthlyScreen extends StatelessWidget {
  const ExpensesMonthlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundApp(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ButtonPrimaryText(
            label: 'Add',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
