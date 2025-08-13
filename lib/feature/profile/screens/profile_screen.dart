part of 'screens.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _createdAtController = TextEditingController();
  final TextEditingController _lastSignInController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {}

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _createdAtController.dispose();
    _lastSignInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundApp(
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorApp.primary,
              ),
            );
          }
          if (state is ProfileLoaded) {
            _displayNameController.text =
                state.response.userMetadata?.displayName ?? '';
            _emailController.text = state.response.email ?? '';
            _lastSignInController.text =
                state.response.lastSignInAt?.getFullDate() ?? '';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextApp(
                  text: 'Profile',
                  size: FontAppSize.font_18,
                  weight: FontAppWeight.bold,
                ),
                const Gap(8),
                const Divider(),
                const Gap(16),
                ItemProfileWidget(
                    label: 'Display Name', controller: _displayNameController),
                const Gap(8),
                const TextApp(
                  text: 'Email',
                  size: FontAppSize.font_14,
                  weight: FontAppWeight.bold,
                ),
                const Gap(8),
                TextFieldApp(
                  controller: _emailController,
                  hintText: '',
                  readOnly: true,
                ),
                const Gap(16),
                const TextApp(
                  text: 'Last Sign In',
                  size: FontAppSize.font_14,
                  weight: FontAppWeight.bold,
                ),
                const Gap(8),
                TextFieldApp(
                  controller: _lastSignInController,
                  hintText: '',
                  readOnly: true,
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
