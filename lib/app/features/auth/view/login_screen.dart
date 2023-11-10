import 'package:app_test_target/app/features/auth/controller/login_controller_cubit.dart';
import 'package:app_test_target/app/features/auth/view/widgets/email_field_widget.dart';
import 'package:app_test_target/app/features/auth/view/widgets/login_button.dart';
import 'package:app_test_target/app/features/auth/view/widgets/password_field_widget.dart';
import 'package:app_test_target/app/features/home/view/home_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController(text: '');
    TextEditingController passwordController = TextEditingController(text: '');
    final formKey = GlobalKey<FormState>(debugLabel: '_LoginFormState');

    return BlocConsumer<LoginControllerCubit, LoginControllerState>(
      listener: (context, state) {
        if (state is LoginControllerSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePageScreen()),
              (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1F4D60),
                  Color(0xFF33908A),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    EmailTextFieldWidget(
                      controller: emailController,
                      validator: (text) => context
                          .read<LoginControllerCubit>()
                          .validateField(key: formKey),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    PasswordTextFieldWidget(
                      controller: passwordController,
                      validator: (text) => context
                          .read<LoginControllerCubit>()
                          .validateField(key: formKey),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    LoginButton(
                      isLoading: state is LoginControllerLoading,
                      onPressed: () async {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          return await context
                              .read<LoginControllerCubit>()
                              .login(
                                user: emailController.text,
                                password: passwordController.text,
                              );
                        }
                      },
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () async {
                        await launchUrl(
                          Uri.parse(
                            'https://www.google.com.br',
                          ),
                        );
                      },
                      child: const Text(
                        'Política de Privacidade',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
