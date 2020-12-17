import 'package:flutter/material.dart';
import './views/home_view.dart';
import 'package:flutter/services.dart';

main() {
  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: HomeView()),
    );
  }
}
