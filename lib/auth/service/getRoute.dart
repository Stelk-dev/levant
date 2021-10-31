import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levant/database/database.dart';
import 'package:levant/model/modelAccount/profile.dart';
import 'package:levant/auth/main/login.dart';
import 'package:levant/auth/service/authentication.dart';
import 'package:levant/main/app.dart';

// Getting the right route where to go
class GetRoute {
  static final db = Db();

  static Future<Widget> getRouteInit() async {
    final userExist = await db.userExist(uid: Auth().idDb());

    print("###########\nUSER EXIST: $userExist");

    if (userExist) {
      final dataUser = await db.dataDocument(doc: Auth().idDb());
      Get.put(Profile()).initProfileFromDb(data: dataUser);

      return App();
    } else
      return AuthRoute();
  }
}
