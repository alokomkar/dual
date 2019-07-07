import 'package:dual_mode/ui/chapters/create_simple_topic_screen.dart';
import 'package:dual_mode/ui/chapters/simple_topics_screen.dart';
import 'package:dual_mode/ui/home/dashboard_screen.dart';
import 'package:dual_mode/ui/language/language_selection_screen.dart';
import 'package:dual_mode/ui/questions/drag_and_drop_code_screen.dart';
import 'package:dual_mode/ui/questions/multichoice_code_screen.dart';
import 'package:dual_mode/ui/questions/multichoice_screen.dart';
import 'package:dual_mode/ui/questions/rearrange_code_screen.dart';
import 'package:dual_mode/ui/questions/syntax_learn_screen.dart';
import 'package:dual_mode/ui/signup/login_screen.dart';
import 'package:flutter/material.dart';

import 'app_state_widget.dart';
import 'base/routes.dart';

void main() => runApp(AppStateWidget(child: DualCodeApp()));

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
        DashboardRoute: (context) => DashboardScreen(),
        LoginScreenRoute: (context) => LoginScreen(),
        LanguageSelectionScreenRoute: (context) => LanguageSelectionScreen(),
        SimpleContentScreenRoute: (context) => SimpleContentScreen(),
        RearrangeCodeScreenRoute: (context) => RearrangeCodeScreen(),
        MultiChoiceScreenRoute: (context) => MultiChoiceScreen(),
        MultiChoiceCodeScreenRoute: (context) => MultiChoiceCodeScreen(),
        DragNDropCodeScreenRoute: (context) => DragNDropCodeScreen(),
        SyntaxLearnScreenRoute: (context) => SyntaxLearnScreen(),
        CreateSimpleTopicScreenRoute: (context) => CreateSimpleTopicScreen()
      },
    );
  }
}
