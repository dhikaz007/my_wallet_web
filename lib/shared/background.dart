part of 'shared.dart';

class BackgroundApp extends StatelessWidget {
  final Widget child;
  final bool isScrollable;
  const BackgroundApp({
    super.key,
    required this.child,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16),
            child: RouteBreadcrumb(),
          ),
          const Gap(12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: ColorApp.white,
              child: Visibility(
                visible: isScrollable,
                replacement: child,
                child: SingleChildScrollView(
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
