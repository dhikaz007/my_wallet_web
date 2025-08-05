part of 'shared.dart';

enum SnackbarAppType { success, info, error }

class SnacbarApp extends StatelessWidget {
  final SnackbarAppType type;
  final String message;
  const SnacbarApp({super.key, required this.type, this.message = ''});

  @override
  Widget build(BuildContext context) {
    final snackBarType = {
      SnackbarAppType.success: ColorApp.green,
      SnackbarAppType.info: ColorApp.orange,
      SnackbarAppType.error: ColorApp.red,
    };
    final snackBarTitle = {
      SnackbarAppType.success: 'Success',
      SnackbarAppType.info: 'Info',
      SnackbarAppType.error: 'Error',
    };

    return Align(
      alignment: Alignment.topCenter,
      child: SafeArea(
        child: Material(
          color: ColorApp.transparent,
          child: Container(
            clipBehavior: Clip.hardEdge,
            width: 300,
            margin: const EdgeInsets.symmetric(vertical: 32),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: snackBarType[type],
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: ColorApp.black.withOpacity(.5),
                  offset: const Offset(0, 3),
                  blurRadius: 4,
                ),
              ],
            ),
            child: ListTile(
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: ColorApp.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorApp.white, width: 1.5),
                ),
                child: const Icon(
                  size: 12,
                  Icons.check,
                  color: ColorApp.white,
                ),
              ),
              title: TextApp(
                text: snackBarTitle[type] ?? '',
                size: FontAppSize.font_14,
                weight: FontAppWeight.medium,
                color: ColorApp.white,
              ),
              subtitle: TextApp(
                text: message,
                size: FontAppSize.font_12,
                maxLines: 3,
                color: ColorApp.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
