import 'package:alliance_tech_check_in/config/constants.dart';
import 'package:alliance_tech_check_in/config/enums.dart';
import 'package:alliance_tech_check_in/config/theme.dart';
import 'package:alliance_tech_check_in/generated/i18n.dart';
import 'package:alliance_tech_check_in/locator.dart';
import 'package:alliance_tech_check_in/repositories/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alliance_tech_check_in/utils/extensions/text_ext.dart';
import 'package:alliance_tech_check_in/features/common/common_widgets.dart';

class LoginScreen extends StatefulWidget {
  final SharedPreferences sharedPreferences;
  final LoginState _passedState = LoginState.NONE;

  LoginScreen()
      : sharedPreferences = sl();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final AuthRepository authService;
  final SharedPreferences sharedPreferences;

  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  AnimationController _entryController;
  Animation<double> _entryAnimation;
  AnimationController _optionsController;
  Animation<double> _optionsAnimation;
  AnimationController _passwordController;
  Animation<double> _passwordAnimation;


  bool checkedValue = false;

  bool buttonVisible = true;
  bool optionsRowVisible = true;
  String _prevText = "";
  LoginState currentState = LoginState.NONE;

  _LoginScreenState()
      : authService = sl(),
        sharedPreferences = sl();

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _entryAnimation = CurvedAnimation(parent: _entryController, curve: Curves.fastOutSlowIn);

    _optionsController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _optionsAnimation = CurvedAnimation(parent: _optionsController, curve: Curves.fastOutSlowIn);

    _passwordController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _passwordAnimation = CurvedAnimation(parent: _passwordController, curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    // _prevText = S.of(context).continueButton;

    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: AppColors.backgroundLight),
            child: SafeArea(
                child: Container(
                    color: AppColors.backgroundLight,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 100, 25, 25),
                            child: Image(image: AssetImage("assets/hipr_logo_full.png"), height: 125),
                          ),
                          SizeTransition(
                              sizeFactor: _entryAnimation,
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: _credentialsRow()
                              )
                          ),
                          AnimatedOpacity(
                            opacity: currentState != LoginState.NONE ? 0.0 : 1.0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn,
                            child: Padding(
                              padding: EdgeInsets.only(top: 24),
                              child: _signInRow(),
                            ),
                            onEnd: () {
                              setState(() {
                                buttonVisible = currentState == LoginState.NONE;
                                optionsRowVisible = currentState == LoginState.LOGIN;
                              });
                            },
                          )
                        ],
                      ),
                    )
                )
            )
        )
    );
  }

  Widget _credentialsRow() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      !optionsRowVisible ? _nameField() : SizedBox(height: 0),
      _emailField(),
      _passwordField(),
      optionsRowVisible ? _optionsRowWrapper() : SizedBox(height: 0),
      _proceedRow()
    ],
  );

  Widget _signInRow() => Visibility(
      visible: buttonVisible,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _loginButton(),
            _signInButton(),
            _registerButton(),
            _skipButton()
          ]
      )
  );

  Widget _proceedRow() {
    return Padding(
        padding: EdgeInsets.fromLTRB(8, 24, 8, 16),
        child: Row(
          children: [
            Expanded(
                child: _backButton()
            ),
            Expanded(
                child: _continueButton()
            )
          ],
        )
    );
  }

  Widget _optionsRowWrapper() =>  SizeTransition(
      sizeFactor: _optionsAnimation,
      child: _optionsRow()
  );

  Widget _optionsRow() => Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Builder(builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Checkbox(
                        value: checkedValue,
                        onChanged: _onRememberMeChanged
                    ),
                  ),
                  SizedBox(width: 7,),
                  Text(
                    S.of(context).remember_me,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Text(
                S.of(context).forgot_password,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                setState(() {
                  currentState = LoginState.RESET;
                  _optionsController.reverse();
                  _passwordController.reverse();
                });
              },
            )
          ],
        );
      })
  );

  Widget _nameField() => Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextField(
          obscureText: false,
          controller: _nameTextController,
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: S.of(context).name_hint,
          )
      )
  );

  Widget _emailField() => Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextField(
          obscureText: false,
          controller: _emailTextController,
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: S.of(context).email_hint,
          )
      )
  );

  Widget _passwordField() => SizeTransition(
      sizeFactor: _passwordAnimation,
      child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextField(
            obscureText: true,
            controller: _passwordTextController,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: S.of(context).password_hint,
            ),
          )
      )
  );

  Widget _skipButton() {
    return Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              _launchHomeScreen();
            },
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                    S.of(context).skipLogin,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5.toDark().bigger(2).toNormal()
                )
            ),
          );
        }
    );
  }

  Widget _loginButton() {
    return GestureDetector(
      onTap: () {
        _setNextState(LoginState.LOGIN);
      },
      child: Padding(
          padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
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

  Widget _registerButton() {
    return GestureDetector(
      onTap: () {
        _setNextState(LoginState.REGISTER);
      },
      child: Padding(
          padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColors.darkGray,
                  borderRadius: BorderRadius.all(Radius.circular(3))
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child:Text(
                    S.of(context).register,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5.toLight().bigger(2).toNormal()
                ),
              )
          )
      ),
    );
  }

  Widget _signInButton() {
    return GestureDetector(
        onTap: () {
          authService.signInWithGoogle().then((token) {
            if (token.token != null) {
              _launchHomeScreen();
            }
          });
        },
        child: Padding(
            padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.backgroundColor
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(3))
                ),
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage("assets/google_logo.png"), height: 20),
                        Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                                S.of(context).google_sign_in,
                                style: Theme.of(context).textTheme.headline6.toDark().bigger(5).toThin()
                            )
                        ),
                      ],
                    )
                )
            )
        )
    );
  }

  Widget _continueButton() {
    String continueText = "";
    switch (currentState) {
      case LoginState.NONE:
        continueText = _prevText;
        break;
      case LoginState.LOGIN:
        continueText = S.of(context).continueButton;
        break;
      case LoginState.REGISTER:
        continueText = S.of(context).registerButton;
        break;
      case LoginState.RESET:
        continueText = S.of(context).resetButton;
        break;
      default: {
        //do nothing
      }
    }
    _prevText = continueText;

    return Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              var name = _nameTextController.text;
              var email = _emailTextController.text.trim().replaceAll("[\\n\\t ]", "");
              var password = _passwordTextController.text;
              _signIn(context, name, email, password);
            },
            child: Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(3))
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                          continueText,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5.toLight().bigger(2).toNormal()
                      ),
                    )
                )
            ),
          );
        }
    );
  }

  Widget _backButton() {
    return GestureDetector(
      onTap: () {
        LoginState nextState = currentState == LoginState.RESET ? LoginState.LOGIN : LoginState.NONE;
        _setNextState(nextState);
      },
      child: Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.backgroundColor
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(3))
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                    S.of(context).backButton,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5.toDark().bigger(2).toNormal().setColor(AppColors.backgroundColor)
                ),
              )
          )
      ),
    );
  }

  void _signIn(BuildContext context, String name, String email, String password) {
    switch (currentState) {
      case LoginState.NONE:
        break;
      case LoginState.LOGIN:
        if (password?.isNotEmpty ?? false) {
          authService.signInWithEmail(email, password).then((token) {
            _validateToken(context, token);
          });
        }
        else {
          textSnackBar(context, S.of(context).invalid_password);
        }
        break;
      case LoginState.REGISTER:
        if (password?.isNotEmpty ?? false) {
          authService.registerUser(name, email, password);
        }
        else {
          textSnackBar(context, S.of(context).invalid_password);
        }
        break;
      case LoginState.RESET:
        textSnackBar(context, S.of(context).resetMessage);
        authService.resetPassword(email);
        _setNextState(LoginState.LOGIN);
        break;
      default: {
        //do nothing
      }
    }
  }

  void _validateToken(BuildContext context, IdTokenResult token) {
    if (token != null) {
      _launchHomeScreen();
    }
    else {
      textSnackBar(context, S.of(context).invalidCredentials);
    }
  }

  void _launchHomeScreen() {
    Navigator.pushReplacementNamed(context, surveyScreen);
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
    checkedValue = newValue;
    //remember username here
  });

  void _setNextState(LoginState nextState) {
    setState(() {
      currentState = nextState;
      switch (nextState) {
        case LoginState.NONE:
          buttonVisible = true;
          _entryController.reverse();
          break;
        case LoginState.LOGIN:
          optionsRowVisible = true;
          _entryController.forward();
          _optionsController.forward();
          _passwordController.forward();
          break;
        case LoginState.REGISTER:
          optionsRowVisible = false;
          _entryController.forward();
          _passwordController.forward();
          break;
        case LoginState.RESET:
          break;
        default: {
          //do nothing
        }
      }
    });
  }
}