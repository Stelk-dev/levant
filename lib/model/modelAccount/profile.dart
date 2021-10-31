import 'package:get/get.dart';
import 'package:levant/auth/service/authentication.dart';

class Profile extends GetxController {
  String name = "";
  String email = "";
  String uid = "";
  String imgProfile = "";
  Map<String, List> tickets = {};

  // Used when user is new, used in authentication
  void initProfile({
    required String n,
    required String e,
    required String u,
    required String img,
  }) {
    name = n;
    email = e;
    uid = u;
    imgProfile = img;

    update();
  }

  // Used when user is authenticated in GetRoute
  void initProfileFromDb({required Map<String, dynamic> data}) {
    uid = Auth().auth.currentUser!.uid;
    name = data["Name"];
    email = data["Email"];
    imgProfile = data["Image"];
    tickets = Map<String, List>.from(data["Tickets"]);

    update();
  }

  void printDataProfile() {
    print(
        "INIT PROFILE:\nName: $name\nEmail: $email\nImg: $imgProfile\nUid: $uid\nTickets: $tickets");
  }
}
