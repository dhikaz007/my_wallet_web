part of 'shared.dart';

class DialogApp extends StatelessWidget {
  final String msg;
  final VoidCallback? yesBtn;
  final VoidCallback? noBtn;
  const DialogApp({super.key, required this.msg, this.yesBtn, this.noBtn});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: ColorApp.primary.shade50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                splashRadius: 4,
                iconSize: 20,
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.close,
                  color: ColorApp.primary,
                ),
              ),
            ),
            const Gap(12),
            Center(child: TextApp(text: msg)),
            const Gap(20),
            Row(
              children: [
                Expanded(
                  child: ButtonPrimary(label: 'Yes', onPressed: yesBtn),
                ),
                const Gap(12),
                Expanded(
                  child: ButtonSecondary(label: 'No', onPressed: noBtn),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
