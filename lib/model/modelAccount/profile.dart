import 'package:get/get.dart';
import 'package:levant/auth/service/authentication.dart';
import 'package:levant/model/modelAccount/db_profile.dart';

class Profile extends GetxController {
  String name = "";
  String email = "";
  String uid = "";
  String imgProfile = "";
  Map<String, List> tickets = {};

  // Used when user is authenticated in GetRoute
  void initProfile({required DatabaseProfileModel data}) {
    uid = Auth().auth.currentUser!.uid;
    name = data.name;
    email = data.email;
    imgProfile = data.img;
    tickets = data.tickets;

    update();
  }

  void changeData({
    required String n,
    required String e,
    required String img,
  }) {
    name = n;
    email = e;
    imgProfile = img;

    update();
  }

  void printDataProfile() {
    print("###########");
    print(
        "PROFILE DATA:\nName: $name\nEmail: $email\nImg: $imgProfile\nUid: $uid\nTickets: $tickets");
    print("###########");
  }
}
