import 'package:flutter/material.dart';
import 'package:levant/style/mainDecoration.dart';
import 'package:levant/style/mainStyle.dart';

class IntroScreenRoute extends StatefulWidget {
  const IntroScreenRoute({Key? key}) : super(key: key);

  @override
  _IntroScreenRouteState createState() => _IntroScreenRouteState();
}

class _IntroScreenRouteState extends State<IntroScreenRoute> {
  Widget section({
    required String image,
    required String title,
    required List<TextSpan> textSpan,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(image),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: Text(
                  title,
                  style: MainFontsApp.poppins_black.copyWith(
                    color: Color.fromRGBO(188, 139, 233, 1),
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: RichText(
                  text: TextSpan(
                    children: textSpan,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(125, 125, 125, 1),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 80, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    width: 50,
                    child: Image.asset("assets/icons/icon_levant.png"),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Levant",
                    style: MainFontsApp.poppins_extra_bold.copyWith(
                      color: MainColorsApp.logo_yellow_color,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: Column(
                children: [
                  section(
                    image: "assets/intro/1.png",
                    title: "Cerca le discoteche",
                    textSpan: [
                      TextSpan(
                        text: "Tutte le discoteche che vuoi,",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(text: " vicine a te, "),
                      TextSpan(
                        text: "in un unico posto",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.grey[800],
                  ),
                  section(
                    image: "assets/intro/2.png",
                    title: "Prenota subito",
                    textSpan: [
                      TextSpan(
                        text: "Riserva",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                          text:
                              " il tuo posto, il tuo tavolo e i tuoi drink, "),
                      TextSpan(
                        text: "senza aspettare",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.grey[800],
                  ),
                  section(
                    image: "assets/intro/3.png",
                    title: "Salta le file",
                    textSpan: [
                      TextSpan(text: "Puoi decidere se pagare in discoteca o"),
                      TextSpan(
                        text: " direttamente nell'app",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            MainDecorationApp.largeButton(
              title: Text(
                "ENJOY",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              function: () => Navigator.pop(context),
              backgroundColor: MainColorsApp.logo_purple_color,
              splashColor: Colors.white10,
              disable: false,
            ),
          ],
        ),
      ),
    );
  }
}
