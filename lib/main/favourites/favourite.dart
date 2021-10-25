import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levant/management/scrollController.dart';

class FavouriteRoute extends StatefulWidget {
  @override
  _FavouriteRouteState createState() => _FavouriteRouteState();
}

class _FavouriteRouteState extends State<FavouriteRoute> {
  final _scrollController = Get.put(ScrollControllerHome());
  List disco = [];

  @override
  Widget build(BuildContext context) {
    return disco.isNotEmpty
        ? ListView.builder(
            controller: _scrollController.controller,
            itemCount: 100,
            itemBuilder: (_, i) => Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Disco salavata: $i°"),
                )))
        : Container(
            child: Center(
            child: Text("Non hai discoteche preferite"),
          ));
  }
}
