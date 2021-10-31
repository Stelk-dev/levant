import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:levant/auth/main/login.dart';
import 'package:levant/auth/service/authentication.dart';
import 'package:levant/main/settings/pages/profile/profileSettings.dart';
import 'package:levant/style/mainDecoration.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              MainDecorationApp.appBarAndGoBackAction(
                title: "Impostazioni",
                context: context,
                action: IconButton(
                  onPressed: () {
                    setState(() => darkMode = !darkMode);
                  },
                  icon: Icon(
                      darkMode ? Icons.dark_mode : Icons.dark_mode_outlined),
                  iconSize: 24,
                  color: Colors.white,
                  splashRadius: 26,
                ),
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
                title: "Aiuto",
                icon: Icons.help_outline_rounded,
                function: () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => ProfileRouteSettings(),
                  ),
                ),
              ),
              sectionButton(
                title: "Termini e condizioni",
                icon: Icons.info_outline,
                function: () => {},
                isNavigatable: false,
              ),
              sectionButton(
                title: "Politica sulla Privacy",
                icon: FlutterIcons.shield_account_outline_mco,
                function: () => {},
                isNavigatable: false,
              ),
              sectionButton(
                title: "About Us",
                icon: FlutterIcons.people_outline_mdi,
                function: () {},
                isNavigatable: false,
              ),
            ],
          ),
          // "Esci" button
          Align(
            alignment: Alignment.bottomLeft,
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
          )
        ],
      ),
    );
  }
}
