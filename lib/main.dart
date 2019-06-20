import 'package:dual_mode/ui/chapters/simple_topics_screen.dart';
import 'package:dual_mode/ui/home/home_screen.dart';
import 'package:dual_mode/ui/language/language_selection_screen.dart';
import 'package:dual_mode/ui/questions/multichoice_screen.dart';
import 'package:dual_mode/ui/signup/login_screen.dart';
import 'package:dual_mode/ui/questions/rearrange_code_screen.dart';
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
      //initialRoute: "/chapters_topic",
      routes: {
        // If you're using navigation routes, Flutter needs a base route.
        // We're going to change this route once we're ready with
        // implementation of HomeScreen.
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/language': (context) => LanguageSelectionScreen(),
        '/chapters_topics': (context) => SimpleContentScreen(),
        '/reorderable_list': (context) => RearrangeCodeScreen(),
        '/multi_choice': (context) => MultiChoiceScreen(),
      },
    );
  }
}


