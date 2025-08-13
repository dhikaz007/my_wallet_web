part of 'shared.dart';

class TextFieldApp extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscure;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? radius;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputAction? textInputAction;
  final bool digitOnly;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final Function(String)? onSubmit;
  final bool noDecor;
  const TextFieldApp({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.suffixIcon,
    this.prefixIcon,
    this.radius,
    this.onChanged,
    this.textInputFormatter,
    this.textInputAction = TextInputAction.done,
    this.digitOnly = false,
    this.validator,
    this.readOnly,
    this.onSubmit,
    this.noDecor = false,
  });

  @override
  State<TextFieldApp> createState() => _TextFieldAppState();
}

class _TextFieldAppState extends State<TextFieldApp> {
  final ValueNotifier<bool> showPass = ValueNotifier(true);

  TextInputFormatter formattedInput() {
    return TextInputFormatter.withFunction(
      (oldValue, newValue) {
        if (newValue.text.isNotEmpty) {
          final formattedValue =
              int.tryParse(newValue.text.replaceAll('.', ''))?.toString();

          if (formattedValue != null) {
            return TextEditingValue(
              text: formattedValue.replaceAllMapped(
                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                (match) => '${match[1]}.',
              ),
              selection: TextSelection.collapsed(offset: formattedValue.length),
            );
          }
        }
        return newValue;
      },
    );
  }

  @override
  void dispose() {
    showPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: showPass,
      builder: (_, __, ___) => TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscure ? showPass.value : false,
        inputFormatters: !widget.digitOnly
            ? widget.textInputFormatter
            : [
                FilteringTextInputFormatter.digitsOnly,
                formattedInput(),
              ],
        textInputAction: widget.textInputAction,
        validator: widget.validator,
        readOnly: widget.readOnly ?? false,
        style: const TextStyle(
          fontSize: 14,
          color: ColorApp.black,
        ),
        decoration: widget.noDecor
            ? InputDecoration.collapsed(hintText: widget.hintText)
            : InputDecoration(
              labelText: '',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 0),
                  borderSide: const BorderSide(color: ColorApp.primary),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 0),
                  borderSide: const BorderSide(color: ColorApp.red),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 0),
                  borderSide: const BorderSide(color: ColorApp.red),
                ),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon ??
                    (widget.obscure == false
                        ? null
                        : InkWell(
                            onTap: () => showPass.value = !showPass.value,
                            child: showPass.value
                                ? const Icon(Icons.visibility_off_outlined)
                                : const Icon(Icons.visibility_outlined),
                          )),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff899197),
                ),
              ),
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmit,
      ),
    );
  }
}
