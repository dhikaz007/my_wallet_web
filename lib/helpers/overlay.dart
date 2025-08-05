part of 'helpers.dart';

class OverlayApp {
  static void showLoad(BuildContext context) {
    if (!context.loaderOverlay.visible) context.loaderOverlay.show();
  }

  static void hideLoad(BuildContext context) {
    if (context.loaderOverlay.visible) context.loaderOverlay.hide();
  }

  static Future<void> showToast(
      BuildContext context, SnackbarAppType type, String message) async {
    final mainState = context.findAncestorStateOfType<MainScreenState>();
    mainState?.showTopSnackBar(context, type, message);
  }
}

class ToastService {
  static final FToast _fToast = FToast();

  static void init(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fToast.init(context);
    });
  }

  static void show({required SnackbarAppType type, String? msg = ''}) {
    _fToast.showToast(
      child: SnacbarApp(
        type: type,
        message: msg ?? '',
      ),
      positionedToastBuilder: (context, child, gravity) => Positioned(
        top: 24,
        left: MediaQuery.sizeOf(context).width / 2.5,
        child: child,
      ),
      gravity: ToastGravity.TOP,
      isDismissible: true,
    );
  }
}
