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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_state_widget.dart';
import 'base/routes.dart';

void main() => runApp(AppStateWidget(child: DualCodeApp()));

class DualCodeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _routes(),
      title: 'Dual Code',
      //theme: buildTheme(),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case DashboardRoute:
          screen = DashboardScreen();
          break;
        case LoginScreenRoute:
          screen = LoginScreen();
          break;
        case LanguageSelectionScreenRoute:
          screen = LanguageSelectionScreen();
          break;
        case SimpleContentScreenRoute:
          screen = SimpleContentScreen(arguments["chapterTitle"]);
          break;
        case RearrangeCodeScreenRoute:
          screen = RearrangeCodeScreen();
          break;
        case MultiChoiceScreenRoute:
          screen = MultiChoiceScreen();
          break;
        case MultiChoiceCodeScreenRoute:
          screen = MultiChoiceCodeScreen();
          break;
        case DragNDropCodeScreenRoute:
          screen = DragNDropCodeScreen();
          break;
        case SyntaxLearnScreenRoute:
          screen = SyntaxLearnScreen();
          break;
        case CreateSimpleTopicScreenRoute:
          screen = CreateSimpleTopicScreen();
          break;
        default:
          return null;
      }
      return CupertinoPageRoute(builder: (BuildContext context) => screen);
    };
  }
}
