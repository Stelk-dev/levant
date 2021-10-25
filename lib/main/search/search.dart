import 'package:flutter/material.dart';

class SearchRoute extends StatefulWidget {
  const SearchRoute({Key? key}) : super(key: key);

  @override
  _SearchRouteState createState() => _SearchRouteState();
}

class _SearchRouteState extends State<SearchRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("SearchRoute"),
      ),
    );
  }
}
