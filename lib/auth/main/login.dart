import 'package:flutter/material.dart';
import 'package:levant/auth/main/registration.dart';
import 'package:levant/auth/service/authentication.dart';
import 'package:levant/my_flutter_app_icons.dart';
import 'package:levant/style/mainDecoration.dart';
import 'package:levant/style/mainStyle.dart';
import 'package:validators/validators.dart';

class AuthRoute extends StatefulWidget {
  @override
  _AuthRouteState createState() => _AuthRouteState();
}

class _AuthRouteState extends State<AuthRoute> {
  bool _loading = false;

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  bool _visibility = false;

  Future<void> authentication(
      {required String method, required Map data}) async {
    setState(() => _loading = true);
    await Auth().allAuthentication(method, data, context);
    setState(() => _loading = false);
  }

  bool buttonDisable() {
    return !(_pass.text.isNotEmpty && _email.text.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Container(
            color: Colors.black,
            child: _loading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: [
                            // TITLE
                            Text(
                              "Levant",
                              style: MainFontsApp.poppins_black.copyWith(
                                fontSize: 56,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 24),
                            // TEXT FORM FIELDS
                            Form(
                              key: _key,
                              child: Column(
                                children: [
                                  MainDecorationApp.textFormField(
                                      controller: _email,
                                      hintText: "Email",
                                      validator: (s) => isEmail(s!)
                                          ? null
                                          : "Inserisci un email valida",
                                      suffixIcon: Icon(
                                        Icons.email,
                                        color: _email.text.isEmpty
                                            ? Colors.white70
                                            : Colors.white,
                                      ),
                                      onChanged: (_) {
                                        setState(() {});
                                      },
                                      obscureText: false,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next),
                                  SizedBox(height: 8),
                                  MainDecorationApp.textFormField(
                                    controller: _pass,
                                    hintText: "Password",
                                    validator: (s) => null,
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          _visibility
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: _pass.text.isEmpty
                                              ? Colors.white70
                                              : Colors.white,
                                        ),
                                        onPressed: () {
                                          _visibility = !_visibility;
                                          setState(() {});
                                        }),
                                    obscureText: !_visibility,
                                    onChanged: (_) {
                                      setState(() {});
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            // LOG IN BUTTON
                            MainDecorationApp.largeButton(
                              title: Text(
                                "Accedi",
                                style: TextStyle(
                                  color: buttonDisable()
                                      ? Colors.white54
                                      : Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              function: () {
                                if (buttonDisable()) return;

                                if (_key.currentState!.validate()) {
                                  authentication(method: "Login", data: {
                                    "Email": _email.text,
                                    "Password": _pass.text,
                                  });
                                }
                              },
                              backgroundColor: Colors.blue,
                              backgroundColorDisabled: Colors.blueGrey,
                              splashColor: Colors.black.withOpacity(.2),
                              disable: buttonDisable(),
                            ),
                            SizedBox(height: 16),
                            // DIVIDER
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.white54,
                                  height: 1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    "Oppure",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  color: Colors.white54,
                                  height: 1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                ),
                              ],
                            ),
                            SizedBox(height: 22),
                            MainDecorationApp.largeButtonWithIcon(
                              icon: Icon(
                                MyFlutterApp.gplus,
                                color: Color.fromRGBO(229, 118, 109, 1),
                              ),
                              title: Text(
                                "Accedi con Google",
                                style: TextStyle(
                                  color: Color.fromRGBO(229, 118, 109, 1),
                                  fontSize: 16,
                                ),
                              ),
                              function: () =>
                                  authentication(method: "Google", data: {}),
                              backgroundColor: Color.fromRGBO(221, 79, 65, 0),
                              splashColor: Colors.redAccent.withOpacity(.1),
                              disable: false,
                            ),
                            SizedBox(height: 8),
                            MainDecorationApp.largeButtonWithIcon(
                              icon: Icon(
                                MyFlutterApp.facebook_squared,
                                color: Color.fromRGBO(87, 153, 235, 1),
                              ),
                              title: Text(
                                "Accedi con Facebook",
                                style: TextStyle(
                                  color: Color.fromRGBO(87, 153, 235, 1),
                                  fontSize: 16,
                                ),
                              ),
                              function: () =>
                                  authentication(method: "Facebook", data: {}),
                              backgroundColor: Color.fromRGBO(221, 79, 65, 0),
                              splashColor: Colors.blueAccent.withOpacity(.1),
                              disable: false,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Non hai un account?",
                            style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => RegistrationPage(),
                              ),
                            ),
                            child: Text(
                              "Registrati",
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
