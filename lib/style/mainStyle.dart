import 'package:flutter/material.dart';

class MainColorsApp {
  /// Color.fromRGBO(230, 230, 230, 1)
  static final Color background_color = Color.fromRGBO(230, 230, 230, 1);

  /// Color.fromRGBO(0, 0, 0, 1)
  static final Color main_color = Color.fromRGBO(0, 0, 0, 1);

  /// Color.fromRGBO(194, 143, 245, 255)
  static final Color primary_button_color = Color.fromRGBO(92, 137, 241, 1);

  /// Color.fromRGBO(220, 248, 134, 1)
  static final Color logo_yellow_color = Color.fromRGBO(220, 248, 134, 1);
}

class MainFontsApp {
  /// Poppins light w300
  static final TextStyle poppins_light =
      TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300);

  /// Poppins normal
  static final TextStyle poppins_normal =
      TextStyle(fontFamily: 'Poppins', fontStyle: FontStyle.normal);

  /// Poppins bold w700
  static final TextStyle poppins_black =
      TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700);

  /// Poppins bold w700
  static final TextStyle poppins_extra_bold =
      TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w900);
}
