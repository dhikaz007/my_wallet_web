part of 'shared.dart';

class ShimerApp extends StatelessWidget {
  final double w;
  final double h;
  const ShimerApp({
    super.key,
    this.w = double.maxFinite,
    this.h = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorApp.grey.withOpacity(.2),
      highlightColor: ColorApp.grey.withOpacity(.3),
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: ColorApp.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
