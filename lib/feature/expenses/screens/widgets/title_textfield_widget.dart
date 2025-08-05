part of 'widgets.dart';

class TitleTextfieldWidget extends StatelessWidget {
  final String label;
  const TitleTextfieldWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextApp(
          text: label,
          size: FontAppSize.font_14,
          weight: FontAppWeight.semiBold,
        ),
        const Gap(4),
        const TextApp(
          text: '*',
          size: FontAppSize.font_14,
          weight: FontAppWeight.semiBold,
          color: Colors.red,
        ),
      ],
    );
  }
}
