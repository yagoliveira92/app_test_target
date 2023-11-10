import 'package:app_test_target/app/common/validators/password_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  const PasswordTextFieldWidget({
    Key? key,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String) validator;

  @override
  _PasswordTextFieldWidgetState createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  FocusNode? focusNode;
  static final _keyPassword = GlobalKey();
  bool _showPassword = true;

  void changeShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Senha',
        ),
        TextFormField(
          style: GoogleFonts.montserrat(),
          onChanged: widget.validator,
          obscureText: _showPassword,
          focusNode: focusNode,
          key: _keyPassword,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            final validate = PasswordValidator(value: value);
            return validate();
          },
          controller: widget.controller,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.lock),
            focusedBorder: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }
}
