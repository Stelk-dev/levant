import 'package:flutter/material.dart';
import 'package:levant/auth/service/authentication.dart';
import 'package:levant/style/mainDecoration.dart';
import 'package:levant/style/mainStyle.dart';
import 'package:validators/validators.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _loading = false;

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _passConfirmed = TextEditingController();
  bool _visibility = false;

  Future<void> authentication(
      {required String method, required Map data}) async {
    setState(() => _loading = true);
    await Auth().allAuthentication(method, data, context);
    setState(() => _loading = false);
  }

  bool buttonDisable() {
    return !(_name.text.isNotEmpty &&
        _email.text.isNotEmpty &&
        _pass.text.isNotEmpty &&
        _passConfirmed.text.isNotEmpty);
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
                                    controller: _name,
                                    hintText: "Nome",
                                    validator: (s) => isLength(s!, 3)
                                        ? null
                                        : "Inserisci un nome lungo almeno 3 caratteri",
                                    suffixIcon: Icon(
                                      Icons.account_circle_outlined,
                                      color: _name.text.isEmpty
                                          ? Colors.white70
                                          : Colors.white,
                                    ),
                                    onChanged: (_) {
                                      setState(() {});
                                    },
                                    obscureText: false,
                                    keyboardType: TextInputType.name,
                                    capitalization: true,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(height: 8),
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
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(height: 8),
                                  MainDecorationApp.textFormField(
                                    controller: _pass,
                                    hintText: "Password",
                                    validator: (s) => isLength(s!, 8)
                                        ? null
                                        : "Inserisci una password di almeno 8 caratteri",
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
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(height: 8),
                                  MainDecorationApp.textFormField(
                                    controller: _passConfirmed,
                                    hintText: "Conferma password",
                                    validator: (s) => _pass.text ==
                                            _passConfirmed.text
                                        ? null
                                        : "Le due password non sono le stesse",
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          _visibility
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: _passConfirmed.text.isEmpty
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
                                "Registrati",
                                style: TextStyle(
                                  color: buttonDisable()
                                      ? Colors.white54
                                      : Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              function: () async {
                                if (buttonDisable()) return;

                                if (_key.currentState!.validate()) {
                                  authentication(
                                    method: "SignUp",
                                    data: {
                                      "Name": _name.text,
                                      "Email": _email.text,
                                      "Password": _pass.text,
                                    },
                                  );
                                }
                              },
                              backgroundColor: Colors.blue,
                              backgroundColorDisabled: Colors.blueGrey,
                              splashColor: Colors.black.withOpacity(.2),
                              disable: buttonDisable(),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hai già un account?",
                            style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              "Accedi",
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
