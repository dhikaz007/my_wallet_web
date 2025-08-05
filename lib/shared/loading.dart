part of 'shared.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 1.5,
        sigmaY: 1.5,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              ImagesApp.imgLogo,
              width: 60,
              height: 60,
            ),
            const Gap(12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: ColorApp.primary,
                  ),
                ),
                Gap(8),
                TextApp(
                  text: 'Loading.....',
                  size: FontAppSize.font_14,
                  weight: FontAppWeight.semiBold,
                  color: ColorApp.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
