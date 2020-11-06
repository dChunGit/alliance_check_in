import 'package:alliance_tech_check_in/features/login/login_screen.dart';
import 'package:alliance_tech_check_in/features/survey/survey_screen.dart';
import 'package:alliance_tech_check_in/generated/i18n.dart';
import 'package:alliance_tech_check_in/utils/transitions/slide_route_transition.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/constants.dart';
import 'config/theme.dart';
import 'locator.dart' as service_locator;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await service_locator.init();
  var sharedPreferences = service_locator.sl.get<SharedPreferences>();

  Widget _defaultHome = LoginScreen();
  if (sharedPreferences.getBool(loginStateKey) ?? false) {
    _defaultHome = SurveyScreen();
  }

  runApp(AllianceApp(defaultHome: _defaultHome,));
}

class AllianceApp extends StatelessWidget {
  final Widget defaultHome;

  AllianceApp({this.defaultHome});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Alliance Tech",
      theme: AllianceTheme.of(context),
      home: defaultHome,
      localizationsDelegates: [
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      onGenerateRoute: (settings) {
        switch(settings.name) {
          case '/login': return SlideRightTransition(page: LoginScreen());
          case '/survey': return SlideRightTransition(page: SurveyScreen());
        }

        return MultiPurposeRoute(exitPage: context.widget, enterPage: SurveyScreen());
      },
    );
  }
}
