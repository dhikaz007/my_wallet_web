part of 'shared.dart';

class ButtonSecondary extends StatelessWidget {
  final String label;
  final Widget? icon;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final IconAlignment align;

  const ButtonSecondary({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.width,
    this.height,
    this.align = IconAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        backgroundColor: ColorApp.white,
        visualDensity: VisualDensity.compact,
        fixedSize: (width == null || height == null)
            ? null
            : Size(width ?? 0.0, height ?? 0.0),
        side: const BorderSide(color: ColorApp.primary),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      iconAlignment: align,
      onPressed: onPressed,
      icon: icon,
      label: TextApp(
        text: label,
        weight: FontAppWeight.medium,
        color: ColorApp.primary,
      ),
    );
  }
}
