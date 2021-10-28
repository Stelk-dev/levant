import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levant/account/profile.dart';
import 'package:levant/auth/main/login.dart';
import 'package:levant/auth/service/authentication.dart';
import 'package:levant/main/app.dart';

// Getting the right route where to go
class GetRoute {
  static Future<Widget> getRouteInit() async {
    final user = Auth().auth.currentUser;

    if (user != null) {
      final profile = Get.put(Profile());
      profile.initProfile(n: user.displayName!, e: user.email!, u: user.uid);
      print(profile.name);

      return App();
    } else
      return AuthRoute();
  }
}
