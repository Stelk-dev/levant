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
    bool capitalization = false,
  }) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: capitalization
          ? TextCapitalization.sentences
          : TextCapitalization.none,
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

  static Widget textFormFieldFull({
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
    required TextInputAction textInputAction,
    Function(String)? onChanged,
    String? Function(String?)? validator,
    bool capitalization = false,
  }) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: capitalization
          ? TextCapitalization.sentences
          : TextCapitalization.none,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        label: Text(hintText),
        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
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

  static Widget appBarAndGoBackAction({
    required String title,
    required BuildContext context,
    Widget? action,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 44, bottom: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back),
                  iconSize: 28,
                  color: Colors.white,
                  splashRadius: 26,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            action ?? Container(),
          ],
        ),
      ),
    );
  }
}
