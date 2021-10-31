import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:levant/auth/service/getRoute.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Widget route = await GetRoute.getRouteInit();
  runApp(
    MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: route,
    ),
  );
}
