part of 'shared.dart';

class DropdownApp<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String? hintText;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  const DropdownApp({
    super.key,
    required this.items,
    this.value,
    this.hintText,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      validator: (value) {
        if (value == null) {
          return 'Pilih salah satu kategori';
        }
        return null;
      },
      hint: TextApp(text: hintText ?? ''),
      focusColor: ColorApp.transparent,
      dropdownColor: ColorApp.white,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorApp.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}
