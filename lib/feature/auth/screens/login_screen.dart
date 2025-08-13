part of 'screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'testing1@gmail.com');
    _passwordController = TextEditingController(text: 'P@ssw0rd');
    _formKey = GlobalKey();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        print(state);
        if (state is AuthLoading) {
          OverlayApp.showLoad(context);
        }
        if (state is! AuthLoading) {
          OverlayApp.hideLoad(context);
        }

        if (state is AuthSuccess) {
          Modular.to.navigate('/');
        }
      },
      child: Scaffold(
        backgroundColor: ColorApp.defaultBackgroud,
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            color: ColorApp.white,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: TextApp(
                      text: 'Login',
                      size: FontAppSize.font_20,
                      weight: FontAppWeight.bold,
                    ),
                  ),
                  const Gap(12),
                  const TextApp(
                    text: 'Email',
                    size: FontAppSize.font_16,
                    weight: FontAppWeight.bold,
                  ),
                  const Gap(8),
                  TextFieldApp(
                    controller: _emailController,
                    hintText: 'example@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  const TextApp(
                    text: 'Password',
                    size: FontAppSize.font_16,
                    weight: FontAppWeight.bold,
                  ),
                  const Gap(8),
                  TextFieldApp(
                    controller: _passwordController,
                    hintText: '123456',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  ButtonPrimary(
                    label: 'Login',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().login(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
