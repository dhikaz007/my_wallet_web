part of 'shared.dart';

class ChartData {
  final String x;
  final double y;

  const ChartData({required this.x, required this.y});

  @override
  String toString() => 'ChartData(x: $x, y: $y)';
}
