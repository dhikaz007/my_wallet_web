part of 'shared.dart';

class ButtonPrimary extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Widget? icon;
  const ButtonPrimary({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        fixedSize: (width == null || height == null)
            ? null
            : Size(width ?? 0.0, height ?? 0.0),
        backgroundColor: ColorApp.primary,
      ),
      onPressed: onPressed,
      icon: icon,
      label: TextApp(
        text: label,
        size: FontAppSize.font_12,
        weight: FontAppWeight.medium,
        color: ColorApp.white,
      ),
    );
  }
}

class ButtonPrimaryText extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const ButtonPrimaryText({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: TextApp(
        text: label,
        size: FontAppSize.font_14,
        weight: FontAppWeight.medium,
        color: ColorApp.primary,
      ),
    );
  }
}
