part of 'shared.dart';

enum FontAppSize {
  font_10,
  font_12,
  font_14,
  font_16,
  font_18,
  font_20,
  font_24,
  font_36,
  font_40
}

enum FontAppWeight { light, normal, medium, semiBold, bold }

extension FontWeightExtension on FontAppWeight {
  FontWeight get value => switch (this) {
        FontAppWeight.light => FontWeight.w300,
        FontAppWeight.normal => FontWeight.w400,
        FontAppWeight.medium => FontWeight.w500,
        FontAppWeight.semiBold => FontWeight.w600,
        FontAppWeight.bold => FontWeight.w700,
      };
}

class TextApp extends StatelessWidget {
  final String text;
  final FontAppSize size;
  final FontAppWeight? weight;
  final Color color;
  final int? maxLines;
  final TextAlign? align;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final FontStyle? style;
  const TextApp({
    super.key,
    required this.text,
    this.size = FontAppSize.font_12,
    this.weight = FontAppWeight.normal,
    this.color = Colors.black,
    this.maxLines = 1,
    this.align,
    this.overflow,
    this.decoration,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: _getSize(),
        fontWeight: weight?.value,
        color: color,
        decoration: decoration,
        fontStyle: style,
      ),
      maxLines: maxLines,
      textAlign: align,
      overflow: overflow,
    );
  }

  double _getSize() {
    switch (size) {
      case FontAppSize.font_10:
        return 10;
      case FontAppSize.font_12:
        return 12;
      case FontAppSize.font_14:
        return 14;
      case FontAppSize.font_16:
        return 16;
      case FontAppSize.font_18:
        return 18;
      case FontAppSize.font_20:
        return 20;
      case FontAppSize.font_24:
        return 24;
      case FontAppSize.font_36:
        return 36;
      case FontAppSize.font_40:
        return 40;
    }
  }
}
