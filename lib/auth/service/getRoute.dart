import 'package:flutter/material.dart';
import 'package:levant/auth/main/login.dart';
import 'package:levant/auth/service/authentication.dart';
import 'package:levant/main/app.dart';

// Getting the right route where to go
class GetRoute {
  static Future<Widget> getRouteInit() async {
    if (Auth().auth.currentUser != null)
      return App();
    else
      return AuthRoute();
  }
}
