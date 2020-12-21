import 'package:alliance_tech_check_in/config/constants.dart';
import 'package:alliance_tech_check_in/config/theme.dart';
import 'package:alliance_tech_check_in/generated/i18n.dart';
import 'package:alliance_tech_check_in/locator.dart';
import 'package:alliance_tech_check_in/services/api/auth_service.dart';
import 'package:alliance_tech_check_in/services/api/auth_service_impl.dart';
import 'package:alliance_tech_check_in/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alliance_tech_check_in/utils/extensions/text_ext.dart';

class PasswordScreen extends StatefulWidget {
  final AuthService _authService;
  final PasswordScreenArgs _args;

  PasswordScreen(args)
      : _args = args,
        _authService = sl();

  @override
  State<StatefulWidget> createState() => _PasswordScreenState();
}

class PasswordScreenArgs {
  final AuthState authState;

  PasswordScreenArgs({this.authState});
}

class _PasswordScreenState extends State<PasswordScreen> {
  bool _passwordHidden = true;
  bool _passwordConfirmHidden = true;

  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _confirmCodeTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _passwordConfirmTextController = TextEditingController();

  final _usernameFormKey = GlobalKey<FormState>();
  final _forgotFormKey = GlobalKey<FormState>();
  final _resetFormKey = GlobalKey<FormState>();
  bool _forgotPasswordState = true;
  bool _isForgotPasswordState = false;

  @override
  void initState() {
    super.initState();
    _isForgotPasswordState = (widget._args.authState == AuthState.FORGOT_PASSWORD);
    if (!_isForgotPasswordState) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _showInfoDialog(S.of(context).first_time_dialog_title, S.of(context).first_time_dialog_message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: (_isForgotPasswordState) ? _createContainerFlow(_isForgotPasswordState) : _createPasswordFlow(_isForgotPasswordState, _resetFormKey)
                  ),
                ),
              ]
          )
        )
      )
    );
  }

  Widget _createContainerFlow(bool _isForgotPasswordState) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 250),
      firstChild: _createUsernameFlow(_isForgotPasswordState),
      secondChild: _createPasswordFlow(_isForgotPasswordState, _forgotFormKey),
      crossFadeState: _forgotPasswordState ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  Widget _createUsernameFlow(bool _isForgotPasswordState) {
    return Form(
      key: _usernameFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _titleField(S.of(context).forgotPassword),
          _nameField(),
          _nextButton(),
          _backButton(_isForgotPasswordState)
        ],
      ),
    );
  }

  Widget _createPasswordFlow(bool _isForgotPasswordState, GlobalKey key) {
    return Form(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _titleField((_isForgotPasswordState) ? S.of(context).forgotPassword : S.of(context).changePassword),
          _passwordField(),
          _passwordConfirmField(),
          (_isForgotPasswordState) ? _confirmationCodeField() : SizedBox(height: 0),
          _changePasswordButton(_isForgotPasswordState),
          _backButton(_isForgotPasswordState)
        ],
      ),
    );
  }

  Widget _titleField(String content) => Padding(
      padding: EdgeInsets.fromLTRB(35, 10, 35, 20),
      child: Text(
        content,
        style: Theme.of(context).textTheme.headline4.setColor(AppColors.darkTextColor)
      )
  );

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

  Widget _confirmationCodeField() => Padding(
      padding: EdgeInsets.fromLTRB(35, 25, 35, 0),
      child: TextFormField(
          obscureText: false,
          controller: _confirmCodeTextController,
          validator: (value) => (value.isEmpty) ? S.of(context).confirmation_error : null,
          style: Theme.of(context).textTheme.bodyText1.bigger(6).setColor(AppColors.darkTextColor),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              prefixIcon: Icon(
                  Icons.confirmation_num_outlined,
                  color: AppColors.darkTextColor
              ),
              hintText: S.of(context).confirm_code_hint,
              hintStyle: Theme.of(context).textTheme.bodyText1.bigger(6).setColor(AppColors.darkTextColor),
              filled: true,
              fillColor: AppColors.backgroundColorDark
          )
      )
  );

  Widget _passwordField() => Padding(
      padding: EdgeInsets.fromLTRB(35, 10, 35, 0),
      child: TextField(
        obscureText: _passwordHidden,
        autocorrect: false,
        controller: _passwordTextController,
        style: Theme.of(context).textTheme.bodyText1.bigger(6).setColor(AppColors.darkTextColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          prefixIcon: Icon(
              Icons.lock_outline,
              color: AppColors.darkTextColor
          ),
          hintText: S.of(context).new_password_hint,
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

  Widget _passwordConfirmField() => Padding(
      padding: EdgeInsets.fromLTRB(35, 10, 35, 0),
      child: TextFormField(
        obscureText: _passwordConfirmHidden,
        autocorrect: false,
        controller: _passwordConfirmTextController,
        validator: (_value) => _validatePassword(_value, _passwordTextController.text.trim()),
        style: Theme.of(context).textTheme.bodyText1.bigger(6).setColor(AppColors.darkTextColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          prefixIcon: Icon(
              Icons.lock_outline,
              color: AppColors.darkTextColor
          ),
          hintText: S.of(context).confirm_password_hint,
          hintStyle: Theme.of(context).textTheme.bodyText1.bigger(6).setColor(AppColors.darkTextColor),
          filled: true,
          fillColor: AppColors.backgroundColorDark,
          suffixIcon: IconButton(
            icon: Icon(
              (_passwordConfirmHidden) ? Icons.visibility : Icons.visibility_off,
              color: AppColors.darkTextColor
            ),
            onPressed: () {
              setState(() {
                _passwordConfirmHidden = !_passwordConfirmHidden;
              });
            },
          ),
        ),
      )
  );

  Widget _changePasswordButton(bool _isForgotPasswordState) {
    return Builder(
      builder: (BuildContext context) => GestureDetector(
        onTap: () {
          var password = _passwordTextController.text.trim();
          var confirmationCode = _confirmCodeTextController.text.trim();

          var isValid = false;
          if (_isForgotPasswordState) {
            isValid = _forgotFormKey.currentState.validate();
          }
          else {
            isValid =_resetFormKey.currentState.validate();
          }

          if (isValid) {
            switch (widget._args.authState) {
              case AuthState.NEW_PASSWORD:
                widget._authService.setPassword(password).then((result) {
                  if (result == AuthState.ERROR) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(S.of(context).password_change_error))
                    );
                  }
                  else {
                    Navigator.pushReplacementNamed(context, surveyScreen);
                  }
                });
                break;
              case AuthState.FORGOT_PASSWORD:
                // issue request for confirmation code
                widget._authService.resetPassword(confirmationCode, password).then((result) {
                  if (!result) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text(S.of(context).password_change_error))
                    );
                  }
                  else {
                    Navigator.pushReplacementNamed(context, loginScreen);
                  }
                });
                break;
              case AuthState.VALID_LOGIN: break;
              case AuthState.INVALID_LOGIN: break;
              case AuthState.ERROR: break;
            }
          }
        },
        child: Padding(
            padding: EdgeInsets.fromLTRB(35, 40, 35, 10),
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColors.accent2,
                    borderRadius: BorderRadius.all(Radius.circular(3))
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child:Text(
                      S.of(context).changePassword,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5.toLight().bigger(2).toNormal()
                  ),
                )
            )
        ),
      ),
    );
  }

  Widget _nextButton() {
    return GestureDetector(
      onTap: () {
        if (_usernameFormKey.currentState.validate()) {
          var _username = _nameTextController.text.trim();
          widget._authService.forgotPassword(_username);
          setState(() {
            _forgotPasswordState = false;
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
              child: Padding(
                padding: EdgeInsets.all(12),
                child:Text(
                    S.of(context).next,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5.toLight().bigger(2).toNormal()
                ),
              )
          )
      ),
    );
  }

  Widget _backButton(_isForgotPasswordScreen) {
    return GestureDetector(
      onTap: () {
        if (_isForgotPasswordScreen && !_forgotPasswordState) {
          setState(() {
            _forgotPasswordState = true;
          });
        }
        else {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }
      },
      child: Padding(
          padding: EdgeInsets.all(24),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.darkTextColor
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(4, 8, 16, 8),
                child: Text(
                  S.of(context).back,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5.toLight().bigger(4).toNormal(),
                ),
              ),
            ],
          )
      ),
    );
  }

  String _validatePassword(String value, String compareValue) {
    if (value.isEmpty) {
      return S.of(context).password_error;
    }
    if (value != compareValue) {
      return S.of(context).password_match_error;
    }

    return null;
  }

  void _showInfoDialog(String title, String message) {
    showSingleActionDialog(context, title, message);
  }
}