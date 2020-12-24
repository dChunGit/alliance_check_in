import 'package:alliance_tech_check_in/features/auth/auth_screen.dart';
import 'package:alliance_tech_check_in/features/auth/password_screen.dart';
import 'package:alliance_tech_check_in/features/survey/survey_screen.dart';
import 'package:alliance_tech_check_in/generated/i18n.dart';
import 'package:alliance_tech_check_in/services/api/auth_service.dart';
import 'package:alliance_tech_check_in/services/api/auth_service_impl.dart';
import 'package:alliance_tech_check_in/utils/transitions/slide_route_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'config/constants.dart';
import 'config/theme.dart';
import 'locator.dart' as service_locator;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await service_locator.init();
  AuthService authService = service_locator.sl.get<AuthService>();
  Widget firstScreen = AuthScreen();

  try {
    var loggedIn = await authService.init();

    if (loggedIn) {
      firstScreen = SurveyScreen();
    }
  } catch (e) {
    print(e);
  }

  initializeDateFormatting();
  runApp(AllianceApp(defaultHome: firstScreen));
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
        final PasswordScreenArgs args = settings.arguments;

        switch(settings.name) {
          case surveyScreen: return SlideLeftTransition(page: SurveyScreen());
          case loginScreen: return SlideRightTransition(page: AuthScreen());
          case passwordScreen: return SlideLeftTransition(page: PasswordScreen(args));
        }
        return MultiPurposeRoute(exitPage: context.widget, enterPage: AuthScreen());
      },
    );
  }
}
