import 'package:flutter/material.dart';
import 'package:levant/style/mainDecoration.dart';

class NotificationRouteSettings extends StatefulWidget {
  const NotificationRouteSettings({Key? key}) : super(key: key);

  @override
  _NotificationRouteSettingsState createState() =>
      _NotificationRouteSettingsState();
}

class _NotificationRouteSettingsState extends State<NotificationRouteSettings> {
  bool _switch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          MainDecorationApp.appBarAndGoBackAction(
              title: "Notifiche", context: context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Ricevere notifiche",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Switch(
                      value: _switch,
                      inactiveTrackColor: Colors.grey,
                      onChanged: (v) {
                        setState(() => _switch = v);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Tutte le notifche verranno inviate all'email del tuo profilo corrispondente",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
