import 'package:flutter/material.dart';
import 'package:levant/style/mainDecoration.dart';

class HelpRouteSettings extends StatefulWidget {
  const HelpRouteSettings({Key? key}) : super(key: key);

  @override
  _HelpRouteSettingsState createState() => _HelpRouteSettingsState();
}

class _HelpRouteSettingsState extends State<HelpRouteSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          MainDecorationApp.appBarAndGoBackAction(
              title: "Aiuto", context: context),
          MainDecorationApp.sectionOtpionButton(
            title: "Supporto",
            icon: Icons.question_answer_outlined,
            function: () {},
            isNavigatable: false,
          ),
          MainDecorationApp.sectionOtpionButton(
            title: "Feedback",
            icon: Icons.feedback_outlined,
            function: () {},
            isNavigatable: false,
          ),
        ],
      ),
    );
  }
}
