import 'package:alliance_tech_check_in/config/theme.dart';
import 'package:alliance_tech_check_in/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alliance_tech_check_in/utils/extensions/text_ext.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light.copyWith(statusBarColor: AppColors.backgroundColor),
            child: SafeArea(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                    child: Container(
                        color: AppColors.backgroundColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
                              child: Image(image: AssetImage("assets/alliancelogo.png"), height: 125),
                            ),
                            _createLoginFields()
                          ],
                        )
                    ),
                  ),
                )
            )
        )
    );
  }

  Widget _createLoginFields() {
    return Column(
      children: [
        _emailField(),
        _passwordField(),
        _loginButton()
      ],
    );
  }

  Widget _nameField() => Padding(
      padding: EdgeInsets.fromLTRB(35, 10, 35, 0),
      child: TextField(
        obscureText: false,
        controller: _nameTextController,
        style: Theme.of(context).textTheme.bodyText1.bigger(6).setColor(AppColors.darkTextColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          prefixIcon: Icon(
            Icons.person,
            color: AppColors.darkTextColor
          ),
          hintText: S.of(context).name_hint,
          hintStyle: Theme.of(context).textTheme.bodyText1.bigger(6).setColor(AppColors.darkTextColor),
          filled: true,
          fillColor: AppColors.backgroundColorDark
        )
      )
  );

  Widget _emailField() => Padding(
      padding: EdgeInsets.fromLTRB(35, 10, 35, 0),
      child: TextField(
        obscureText: false,
        controller: _emailTextController,
        style: Theme.of(context).textTheme.bodyText1.bigger(6).setColor(AppColors.darkTextColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          prefixIcon: Icon(
              Icons.email,
              color: AppColors.darkTextColor
          ),
          hintText: S.of(context).email_hint,
          hintStyle: Theme.of(context).textTheme.bodyText1.bigger(6).setColor(AppColors.darkTextColor),
          filled: true,
          fillColor: AppColors.backgroundColorDark
        )
      )
  );

  Widget _passwordField() => Padding(
      padding: EdgeInsets.fromLTRB(35, 10, 35, 0),
      child: TextField(
        obscureText: true,
        autocorrect: false,
        controller: _passwordTextController,
        style: Theme.of(context).textTheme.bodyText1.bigger(6).setColor(AppColors.darkTextColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          prefixIcon: Icon(
              Icons.lock,
              color: AppColors.darkTextColor
          ),
          hintText: S.of(context).password_hint,
          hintStyle: Theme.of(context).textTheme.bodyText1.bigger(6).setColor(AppColors.darkTextColor),
          filled: true,
          fillColor: AppColors.backgroundColorDark
        ),
      )
  );

  Widget _loginButton() {
    return GestureDetector(
      onTap: () {
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(35, 40, 35, 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.all(Radius.circular(3))
          ),
          child: Padding(
            padding: EdgeInsets.all(12),
            child:Text(
              S.of(context).login,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5.toLight().bigger(2).toNormal()
            ),
          )
        )
      ),
    );
  }
}