import 'package:get/get.dart';

class Profile extends GetxController {
  String name = "";
  String email = "";
  String uid = "";
  String imgProfile = "";

  void initProfile({
    required String n,
    required String e,
    required String u,
    required String img,
  }) {
    print("INIT PROFILE:\nName: $n\nEmail: $e\nImg: $img\nUid: $u");

    name = n;
    email = e;
    uid = u;
    imgProfile = img;

    update();
  }
}
