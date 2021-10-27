import 'package:flutter/material.dart';
import 'package:levant/auth/main/registration.dart';
import 'package:levant/style/mainStyle.dart';

class AuthRoute extends StatefulWidget {
  @override
  _AuthRouteState createState() => _AuthRouteState();
}

class _AuthRouteState extends State<AuthRoute> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/background/startScreen.gif",
              ),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: _loading
              ? CircularProgressIndicator()
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Levant",
                        style: MainFontsApp.poppins_black.copyWith(
                            fontSize: 56,
                            color: MainColorsApp.logo_yellow_color),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: TextButton(
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => RegistrationPage())),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                "ENTRA",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            overlayColor: MaterialStateProperty.all(
                              MainColorsApp.logo_yellow_color.withOpacity(.1),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                                side: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
