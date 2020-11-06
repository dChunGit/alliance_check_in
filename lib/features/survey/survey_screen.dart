import 'package:alliance_tech_check_in/config/theme.dart';
import 'package:alliance_tech_check_in/features/common/custom_header_bar.dart';
import 'package:alliance_tech_check_in/locator.dart';
import 'package:alliance_tech_check_in/repositories/auth/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alliance_tech_check_in/utils/extensions/text_ext.dart';

class SurveyScreen extends StatefulWidget {
  final AuthRepository _authService;
  final SharedPreferences _sharedPreferences;

  SurveyScreen()
      : _authService = sl(),
        _sharedPreferences = sl();

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  Map<String, List<String>> dynamicEntries = Map<String, List<String>>();
  Map<String, TextEditingController> dynamicTextFieldControllers = Map<String, TextEditingController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(statusBarColor: AppColors.headerColor),
        child: Scaffold(
            appBar: CustomHeaderBar(
              height: 100,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.chevronLeft,
                              color: AppColors.icons,
                            ),
                            Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                    "Back",
                                    style: Theme.of(context).textTheme.headline4.toLight().smaller(2)
                                )
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/home');
                        },
                      ),
                      Image(
                          image: AssetImage("assets/hiprlogo.png"),
                          height: 30.0
                      ),
                    ]
                ),
              ),
            ),
            body: Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.topCenter,
                  overflow: Overflow.visible,
                  children: [],
                )
            )
        )
    );
  }
}
