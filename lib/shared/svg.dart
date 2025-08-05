part of 'shared.dart';

class SvgApp extends StatelessWidget {
  final String asset;
  final BoxFit fit;
  final Color? color;
  final double? width;
  final double? height;
  const SvgApp({
    super.key,
    required this.asset,
    this.fit = BoxFit.contain,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      fit: fit,
      width: width,
      height: height,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(
              color ?? ColorApp.black,
              BlendMode.srcIn,
            ),
    );
  }
}
