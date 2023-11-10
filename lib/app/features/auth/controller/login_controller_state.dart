part of 'login_controller_cubit.dart';

@immutable
abstract class LoginControllerState {}

class LoginControllerInitial extends LoginControllerState {}

class LoginControllerLoading extends LoginControllerState {}

class LoginControllerSuccess extends LoginControllerState {
  final LoginModel loginModel;
  LoginControllerSuccess({required this.loginModel});
}

class LoginControllerError extends LoginControllerState {}
