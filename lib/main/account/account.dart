import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levant/account/profile.dart';

class AccountRoute extends StatefulWidget {
  const AccountRoute({Key? key}) : super(key: key);

  @override
  _AccountRouteState createState() => _AccountRouteState();
}

class _AccountRouteState extends State<AccountRoute> {
  final profile = Get.put(Profile());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:
            Text("Profile:\n${profile.name} ${profile.email} ${profile.uid}"),
      ),
    );
  }
}
