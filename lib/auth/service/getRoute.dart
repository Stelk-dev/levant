import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levant/model/modelAccount/profile.dart';
import 'package:levant/auth/main/login.dart';
import 'package:levant/auth/service/authentication.dart';
import 'package:levant/main/app.dart';

// Getting the right route where to go
class GetRoute {
  static Future<Widget> getRouteInit() async {
    final user = Auth().auth.currentUser;

    print("GET ROUTE INIT:\nUser != null: ${user != null}");

    if (user != null) {
      final profile = Get.put(Profile());

      profile.initProfile(
        n: user.displayName!,
        e: user.email!,
        u: user.uid,
        img: user.photoURL ?? "",
      );

      return App();
    } else
      return AuthRoute();
  }
}
