import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levant/modelAccount/profile.dart';
import 'package:levant/style/mainStyle.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class AccountRoute extends StatefulWidget {
  const AccountRoute({Key? key}) : super(key: key);

  @override
  _AccountRouteState createState() => _AccountRouteState();
}

class _AccountRouteState extends State<AccountRoute> {
  final profile = Get.put(Profile());

  // If in the name there are space just take the first
  String getName() {
    return profile.name.split(' ')[0];
  }

  Widget accountSection() {
    return TouchableOpacity(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 20, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                        profile.imgProfile != ""
                            ? profile.imgProfile
                            : "https://icon-library.com/images/no-profile-picture-icon/no-profile-picture-icon-13.jpg",
                        fit: BoxFit.cover, loadingBuilder: (_, child, chunk) {
                      return chunk == null
                          ? child
                          : Center(
                              child: CircularProgressIndicator(),
                            );
                    }),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getName(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      profile.email,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.grey, border: Border.all(color: Colors.grey, width: 1)),
    );
  }

  Widget sectionButton({
    required IconData icon,
    required String title,
  }) {
    return TextButton(
      onPressed: () {},
      // style: ButtonStyle(
      //   backgroundColor: MaterialStateProperty.all(color),
      // ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 36,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text(
                  title,
                  style: MainFontsApp.poppins_normal
                      .copyWith(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        // accountSection(),
        // divider(),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Impostazioni",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
        ),
        // divider(),
        SizedBox(
          height: 30,
        ),
        sectionButton(
            icon: Icons.account_circle_outlined, title: "Il tuo profilo"),
        divider(),
        sectionButton(icon: Icons.topic, title: "Biglietti"),
        divider(),
        sectionButton(icon: Icons.topic, title: ""),
        divider(),
        sectionButton(icon: Icons.topic, title: "About Us"),
        divider(),
      ],
    ));
  }
}
