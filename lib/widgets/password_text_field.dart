import 'package:flutter/material.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';

class PasswordTextField extends StatefulWidget {

  final TextEditingController passwordController;
  final String hintText;

  const PasswordTextField({
    Key? key,
    required this.passwordController,
    required this.hintText,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passwordController,
      style: TextStyle(
        fontSize: Dimensions.screenHeight / 58.25,
        color: Colors.black,
      ),
      cursorColor: AppColors.primaryColor,
      obscureText: _obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          vertical: Dimensions.screenHeight / 62.133,
          horizontal: Dimensions.screenWidth / 21.5,
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: Dimensions.screenWidth / 430,
            color: AppColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: Dimensions.screenWidth / 286.667,
            color: AppColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(Dimensions.screenHeight / 62.133),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: AppColors.primaryColor,
          ),
          onPressed: _toggleVisibility,
        ),
      ),
    );
  }
}
