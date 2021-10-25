import 'package:flutter/material.dart';
import 'package:levant/auth/service/authentication.dart';

class AuthRoute extends StatefulWidget {
  @override
  _AuthRouteState createState() => _AuthRouteState();
}

class _AuthRouteState extends State<AuthRoute> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                      onPressed: () {
                        setState(() => _loading = true);

                        Auth().allAuthentication("Google", {}, context);
                      },
                      child: Text("Google sign in",
                          style: TextStyle(color: Colors.white)),
                      color: Colors.red),
                  FlatButton(
                      onPressed: () {
                        setState(() => _loading = true);

                        Auth().allAuthentication("Facebook", {}, context);
                      },
                      child: Text("Facebook sign in",
                          style: TextStyle(color: Colors.white)),
                      color: Colors.blue),
                ],
              ),
      ),
    );
  }
}
