import 'package:get/get.dart';

class Profile extends GetxController {
  String name = "";
  String email = "";
  String uid = "";

  void initProfile({
    required String n,
    required String e,
    required String u,
  }) {
    name = n;
    email = e;
    uid = u;

    update();
  }
}
