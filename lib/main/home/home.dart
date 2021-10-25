import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levant/management/scrollController.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  final _scrollController = Get.put(ScrollControllerHome());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          controller: _scrollController.controller,
          itemCount: 100,
          itemBuilder: (_, i) => Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Discoteca $i°"),
                ),
              )),
    );
  }
}
