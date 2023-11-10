class PasswordValidator {
  PasswordValidator({required this.value});

  final String? value;
  String? call() {
    if (value!.isEmpty) {
      return 'Este campo é obrigatório';
    }
    final regex = RegExp(r"^[a-zA-Z0-9]*$");
    if (!regex.hasMatch(value!)) {
      return 'Senha deve conter apenas números e letras (a-z, A-Z, 0-9)';
    }
    return null;
  }
}
