import 'package:app_test_target/app/features/auth/model/login_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

part 'login_controller_state.dart';

class LoginControllerCubit extends Cubit<LoginControllerState> {
  LoginControllerCubit() : super(LoginControllerInitial());

  Future<void> login({required String user, required String password}) async {
    emit(LoginControllerLoading());
    final response = await loginRequest(user: user, password: password);
    if (response.error) {
      emit(
        LoginControllerSuccess(
          loginModel: response.loginModel,
        ),
      );
    } else {
      emit(LoginControllerError());
    }
  }

  void validateField({required GlobalKey<FormState> key}) {
    key.currentState!.validate();
  }

  Future<({LoginModel loginModel, bool error})> loginRequest(
      {required String user, required String password}) async {
    try {
      final dio = Dio();
      final responseLogin = await dio.post(
        'https://654eb015358230d8f0ccc997.mockapi.io/api/login',
        data: {
          'user': user,
          'password': password,
        },
      );
      if (responseLogin.statusCode! >= 200 && responseLogin.statusCode! < 300) {
        final loginResult = LoginModel.fromJson(responseLogin.data);
        return (loginModel: loginResult, error: false);
      } else {
        return (loginModel: LoginModel(), error: true);
      }
    } on Exception catch (e) {
      return (loginModel: LoginModel(), error: true);
    }
  }
}
