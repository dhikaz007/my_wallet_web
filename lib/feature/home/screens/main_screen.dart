part of 'screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  bool _isExpand = false;

  @override
  void initState() {
    super.initState();
    ToastService.init(context);
    context.read<ProfileCubit>().getUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showRightSheet(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "RightSheet",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 400, // lebar sheet
            height: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                AppBar(title: const Text("Panel dari Kanan")),
                const Expanded(child: Center(child: Text("Konten di sini..."))),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, __, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1, 0),
          end: const Offset(0, 0),
        ).animate(animation);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  void showTopSnackBar(
      BuildContext context, SnackbarAppType type, String message) {
    showGeneralDialog(
      context: context,
      barrierColor: ColorApp.transparent,
      barrierDismissible: false,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SnacbarApp(
          type: type,
          message: message,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutQuad,
          reverseCurve: Curves.easeInQuad,
        );

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1), // mulai dari atas
            end: const Offset(0, 0), // ke posisi normal
          ).animate(curvedAnimation),
          child: FadeTransition(
            opacity: curvedAnimation,
            child: child,
          ),
        );
      },
    );
    // otomatis hilang setelah 2 detik
    Future.delayed(const Duration(seconds: 2), () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFDFD),
        leading: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: IconButton(
              onPressed: () {
                setState(() {
                  _isExpand = !_isExpand;
                });
              },
              icon: const Icon(Icons.menu)),
        ),
        centerTitle: true,
        title: TextApp(
          text:
              "${globalDateNow.getMonth(format: 4)} ${globalDateNow.getYear()}",
          size: FontAppSize.font_20,
        ),
        actions: [
          IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () async {
              await StorageToken().deleteAll();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Row(
        children: [
          SideBarWidget(isExpand: _isExpand),
          const Expanded(child: RouterOutlet()),
        ],
      ),
    );
  }
}
