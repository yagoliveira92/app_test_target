import 'package:app_test_target/app/features/auth/controller/login_controller_cubit.dart';
import 'package:app_test_target/app/features/auth/view/widgets/email_field_widget.dart';
import 'package:app_test_target/app/features/auth/view/widgets/password_field_widget.dart';
import 'package:app_test_target/app/features/home/view/home_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          body: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Center(
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(13.0),
                        ),
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
                        child: state is LoginControllerLoading
                            ? const SizedBox(
                                height: 25.0,
                                width: 25.0,
                                child: CircularProgressIndicator(
                                    color: Colors.blue),
                              )
                            : const Text(
                                'Entrar',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
