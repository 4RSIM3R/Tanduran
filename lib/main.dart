import 'package:flutter/material.dart';
import 'package:tanduran/route/routes.dart';
import 'package:tanduran/view/home.dart';

void main(){
  Routes.createRoutes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tanduran',
      theme: ThemeData(fontFamily: "Sans"),
      onGenerateRoute: Routes.sailor.generator(),
      navigatorKey: Routes.sailor.navigatorKey,
      home: Home(),
    );
  }
}

