import 'package:flutter/material.dart';

class AccountRoute extends StatefulWidget {
  const AccountRoute({Key? key}) : super(key: key);

  @override
  _AccountRouteState createState() => _AccountRouteState();
}

class _AccountRouteState extends State<AccountRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("AccountRoute"),
      ),
    );
  }
}
