import 'package:app_test_target/app/common/validators/password_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFormField(
          style: GoogleFonts.montserrat(),
          onChanged: widget.validator,
          maxLength: 20,
          focusNode: focusNode,
          key: _keyPassword,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            final validate = PasswordValidator(value: value);
            return validate();
          },
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')),
          ],
          controller: widget.controller,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.lock),
            focusedBorder: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
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
