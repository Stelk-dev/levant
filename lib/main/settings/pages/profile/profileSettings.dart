import 'package:flutter/material.dart';

class ProfileRouteSettings extends StatefulWidget {
  const ProfileRouteSettings({Key? key}) : super(key: key);

  @override
  _ProfileRouteSettingsState createState() => _ProfileRouteSettingsState();
}

class _ProfileRouteSettingsState extends State<ProfileRouteSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Text("Account", style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
