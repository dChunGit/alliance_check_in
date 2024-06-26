import 'package:alliance_tech_check_in/config/constants.dart';
import 'package:alliance_tech_check_in/config/theme.dart';
import 'package:alliance_tech_check_in/features/auth/password_screen.dart';
import 'package:alliance_tech_check_in/generated/i18n.dart';
import 'package:alliance_tech_check_in/locator.dart';
import 'package:alliance_tech_check_in/services/api/auth_service.dart';
import 'package:alliance_tech_check_in/services/api/auth_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alliance_tech_check_in/utils/extensions/text_ext.dart';

class AuthScreen extends StatefulWidget {
  final AuthService _authService;

  AuthScreen()
    : _authService = sl();

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _passwordHidden = true;
  bool _signingIn = false;

  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: AppColors.backgroundColor,
          ),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light.copyWith(statusBarColor: AppColors.backgroundColor),
            child: SafeArea(
                child: Stack(
                  children: [
                    Container(
                      color: AppColors.backgroundColor,
                    ),
                    Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(35, 0, 35, 45),
                              child: Image(image: AssetImage("assets/alliancelogo_large.png"), height: 125),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _createLoginFields()
                          ],
                        ),
                      ),
                    ),
                  ]
                )
            )
        )
    );
  }

  Widget _createLoginFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _nameField(),
          _passwordField(),
          _loginButton(),
          _forgotPassword()
        ],
      ),
    );
  }

  Widget _nameField() => Padding(
      padding: EdgeInsets.fromLTRB(35, 10, 35, 0),
      child: TextFormField(
        obscureText: false,
        controller: _nameTextController,
        validator: (value) => (value.isEmpty) ? S.of(context).username_error : null,
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

  Widget _passwordField() => Padding(
      padding: EdgeInsets.fromLTRB(35, 10, 35, 0),
      child: TextFormField(
        obscureText: _passwordHidden,
        autocorrect: false,
        controller: _passwordTextController,
        validator: (value) => (value.isEmpty) ? S.of(context).password_error : null,
        style: Theme.of(context).textTheme.bodyText1.bigger(4).setColor(AppColors.darkTextColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          prefixIcon: Icon(
              Icons.lock,
              color: AppColors.darkTextColor
          ),
          hintText: S.of(context).password_hint,
          hintStyle: Theme.of(context).textTheme.bodyText1.bigger(6).setColor(AppColors.darkTextColor),
          filled: true,
          fillColor: AppColors.backgroundColorDark,
          suffixIcon: IconButton(
            icon: Icon(
              (_passwordHidden) ? Icons.visibility : Icons.visibility_off,
              color: AppColors.darkTextColor
            ),
            onPressed: () {
              setState(() {
                _passwordHidden = !_passwordHidden;
              });
            },
          ),
        ),
      )
  );

  Widget _loginButton() {
    return Builder(
      builder: (BuildContext context) => GestureDetector(
        onTap: () {
          if (_formKey.currentState.validate()) {
            var username = _nameTextController.text.trim();
            var password = _passwordTextController.text.trim();

            setState(() {
              _signingIn = true;
            });

            widget._authService.signIn(username, password).then((value) {
              setState(() {
                _signingIn = false;
              });

              switch (value) {
                case AuthState.NEW_PASSWORD:
                  Navigator.pushNamed(
                      context,
                      passwordScreen,
                      arguments: PasswordScreenArgs(authState: value)
                  );
                  break;
                case AuthState.VALID_LOGIN:
                  Navigator.pushReplacementNamed(context, surveyScreen);
                  break;
                case AuthState.INVALID_LOGIN:
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context).login_cred_error))
                  );
                  break;
                case AuthState.ERROR:
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context).generic_login_error))
                  );
                  break;
                case AuthState.RESET_PASSWORD:
                case AuthState.FORGOT_PASSWORD:
                  Navigator.pushNamed(
                    context,
                    passwordScreen,
                    arguments: PasswordScreenArgs(authState: value)
                  );
                  break;
              }
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(35, 40, 35, 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.all(Radius.circular(3))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child:Text(
                    S.of(context).login,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5.toLight().bigger(2).toNormal()
                  ),
                ),
                Visibility(
                  visible: _signingIn,
                  child: SizedBox(
                      height: 20,
                      width: 20,
                      child: Theme(
                          data: Theme.of(context).copyWith(accentColor: AppColors.darkTextColor),
                          child: CircularProgressIndicator()
                      )
                  ),
                )
              ],
            )
          )
        ),
      ),
    );
  }

  Widget _forgotPassword() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
            context,
            passwordScreen,
            arguments: PasswordScreenArgs(authState: AuthState.FORGOT_PASSWORD)
        );
      },
      child: Padding(
          padding: EdgeInsets.fromLTRB(35, 10, 35, 0),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Text(
                S.of(context).forgotPassword,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5.toLight().toNormal().bigger(4)
            ),
          )
      ),
    );
  }
}