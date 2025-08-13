part of 'widgets.dart';

class ItemProfileWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const ItemProfileWidget({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextApp(
          text: label,
          size: FontAppSize.font_14,
          weight: FontAppWeight.bold,
        ),
        const Gap(40),
        Expanded(
          child: TextFieldApp(
            controller: controller,
            hintText: '',
            readOnly: true,
            noDecor: true,
          ),
        ),
      ],
    );
  }
}
