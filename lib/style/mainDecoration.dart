import 'package:flutter/material.dart';

class MainDecorationApp {
  static Widget textFormField({
    required TextEditingController controller,
    required String hintText,
    required Widget suffixIcon,
    required bool obscureText,
    required TextInputType keyboardType,
    required TextInputAction textInputAction,
    Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromRGBO(32, 32, 32, 1),
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  static Widget largeButton({
    required Text title,
    required Function() function,
    required Color backgroundColor,
    Color backgroundColorDisabled = Colors.transparent,
    required Color splashColor,
    required bool disable,
  }) {
    return TextButton(
      onPressed: function,
      child: Center(
        child: title,
      ),
      style: ButtonStyle(
        splashFactory: disable ? NoSplash.splashFactory : null,
        padding: MaterialStateProperty.all(
          EdgeInsets.all(12),
        ),
        overlayColor: MaterialStateProperty.all(
          splashColor,
        ),
        backgroundColor: MaterialStateProperty.all(
          disable ? backgroundColorDisabled : backgroundColor,
        ),
      ),
    );
  }

  static Widget largeButtonWithIcon({
    required Text title,
    required Icon icon,
    required Function()? function,
    required Color backgroundColor,
    Color backgroundColorDisabled = Colors.transparent,
    required Color splashColor,
    required bool disable,
  }) {
    return TextButton(
      onPressed: function,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(
            width: 18,
          ),
          title
        ],
      ),
      style: ButtonStyle(
        splashFactory: disable ? NoSplash.splashFactory : null,
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        ),
        overlayColor: MaterialStateProperty.all(
          splashColor,
        ),
        backgroundColor: MaterialStateProperty.all(
          disable ? backgroundColorDisabled : backgroundColor,
        ),
      ),
    );
  }
}
