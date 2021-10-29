import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:levant/auth/main/login.dart';
import 'package:levant/auth/service/authentication.dart';
import 'package:levant/main/settings/pages/profile/profileSettings.dart';

class SettingsRoute extends StatefulWidget {
  @override
  _SettingsRouteState createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {
  bool darkMode = true;

  Widget sectionButton({
    required String title,
    required IconData icon,
    required Function()? function,
    bool isNavigatable = true,
  }) {
    return TextButton(
      onPressed: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 26),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
            isNavigatable
                ? Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                    size: 18,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back),
                iconSize: 28,
                color: Colors.white,
                splashRadius: 26,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                "Impostazioni",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          sectionButton(
            title: "Profilo",
            icon: Icons.account_circle_outlined,
            function: () => Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (_) => ProfileRouteSettings(),
              ),
            ),
          ),
          sectionButton(
            title: "Dark mode",
            icon: darkMode ? Icons.dark_mode : Icons.dark_mode_outlined,
            function: () {
              setState(() => darkMode = !darkMode);
            },
            isNavigatable: false,
            // TODO: Create a dialog with
            // Active  Disactive
            // OR
            // A simple moon icon which when you tipe it you can change the icon
          ),
          sectionButton(
            title: "About Us",
            icon: Icons.info_outline,
            function: () {},
            isNavigatable: false,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
              child: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                    overlayColor: MaterialStateProperty.all(
                      Colors.redAccent.withOpacity(.1),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              backgroundColor: Color.fromRGBO(32, 32, 32, 1),
                              title: Text(
                                "Vuoi veramente uscire?",
                                style: TextStyle(color: Colors.white),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Auth().auth.signOut();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => AuthRoute()),
                                        (route) => false);
                                  },
                                  child: Text(
                                    "Conferma",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Annulla"),
                                ),
                              ],
                            ));
                  },
                  child: Text(
                    "Esci",
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
