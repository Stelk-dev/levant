import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levant/database/database.dart';
import 'package:levant/model/modelAccount/db_profile.dart';
import 'package:levant/model/modelAccount/profile.dart';
import 'package:levant/auth/main/login.dart';
import 'package:levant/auth/service/authentication.dart';
import 'package:levant/main/app.dart';

// Getting the right route where to go
class GetRoute {
  static final db = Db();

  static Future<Widget> getRouteInit() async {
    final userExist = await db.userExist(uid: Auth().idDb());

    print("###########");
    print("GetRouteInit: UserExist = $userExist");
    print("###########");

    if (userExist) {
      final dataUser = await db.dataDocument(doc: Auth().idDb());
      final profile = DatabaseProfileModel.fromJson(data: dataUser);
      Get.put(Profile()).initProfile(data: profile);
      Get.put(Profile()).printDataProfile();

      return App();
    } else
      return AuthRoute();
  }
}
