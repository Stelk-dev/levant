import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:levant/auth/main/login.dart';
import 'package:levant/auth/service/authentication.dart';
import 'package:levant/intro/introScreen.dart';
import 'package:levant/main/settings/pages/help/helpPage.dart';
import 'package:levant/main/settings/pages/notification/notificationPage.dart';
import 'package:levant/main/settings/pages/profile/profileSettings.dart';
import 'package:levant/style/mainDecoration.dart';
import 'package:package_info/package_info.dart';

class SettingsRoute extends StatefulWidget {
  @override
  _SettingsRouteState createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {
  bool darkMode = true;
  String _packageVersion = "";

  @override
  void initState() {
    super.initState();
    gettingVersionCode();
  }

  Future<void> gettingVersionCode() async {
    final package = await PackageInfo.fromPlatform();
    setState(() => _packageVersion = "v" + package.version);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
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
                      icon: Icon(darkMode
                          ? Icons.dark_mode
                          : Icons.dark_mode_outlined),
                      iconSize: 24,
                      color: Colors.white,
                      splashRadius: 26,
                    ),
                  ),
                  // #region Section buttons
                  MainDecorationApp.sectionOtpionButton(
                    title: "Profilo",
                    icon: Icons.account_circle_outlined,
                    function: () => Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (_) => ProfileRouteSettings(),
                      ),
                    ),
                  ),
                  MainDecorationApp.sectionOtpionButton(
                    title: "Aiuto",
                    icon: Icons.help_outline_rounded,
                    function: () => Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (_) => HelpRouteSettings(),
                      ),
                    ),
                  ),
                  MainDecorationApp.sectionOtpionButton(
                    title: "Notifiche",
                    icon: Icons.notifications_outlined,
                    function: () => Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (_) => NotificationRouteSettings(),
                      ),
                    ),
                  ),
                  MainDecorationApp.sectionOtpionButton(
                    title: "Come usare l'app",
                    icon: Icons.info_outline,
                    function: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => IntroScreenRoute(),
                      ),
                    ),
                    isNavigatable: false,
                  ),
                  MainDecorationApp.sectionOtpionButton(
                    title: "Termini e condizioni",
                    icon: Icons.assignment_outlined,
                    function: () => {},
                    isNavigatable: false,
                  ),
                  MainDecorationApp.sectionOtpionButton(
                    title: "Politica sulla Privacy",
                    icon: FlutterIcons.shield_account_outline_mco,
                    function: () => {},
                    isNavigatable: false,
                  ),
                  MainDecorationApp.sectionOtpionButton(
                    title: "Noi di Levant",
                    icon: FlutterIcons.people_outline_mdi,
                    function: () {},
                    isNavigatable: false,
                  ),
                  // #endregion
                  _packageVersion.isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _packageVersion,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
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
        ],
      ),
    );
  }
}
