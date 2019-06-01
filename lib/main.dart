import 'package:dual_mode/ui/home.dart';
import 'package:dual_mode/ui/login.dart';
import 'package:flutter/material.dart';

import 'app_state_widget.dart';

void main() => runApp(new AppStateWidget(child : DualCodeApp()));

class DualCodeApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dual Code',
      //theme: buildTheme(),
      //initialRoute: "/",
      routes: {
        // If you're using navigation routes, Flutter needs a base route.
        // We're going to change this route once we're ready with
        // implementation of HomeScreen.
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}


