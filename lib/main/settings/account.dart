import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levant/modelAccount/profile.dart';

class SettingsRoute extends StatefulWidget {
  const SettingsRoute({Key? key}) : super(key: key);

  @override
  _SettingsRouteState createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {
  final profile = Get.put(Profile());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: []),
    );
  }
}
