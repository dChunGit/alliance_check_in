import 'dart:async';
import 'dart:io';

import 'package:alliance_tech_check_in/config/constants.dart';
import 'package:alliance_tech_check_in/config/enums.dart';
import 'package:alliance_tech_check_in/config/theme.dart';
import 'package:alliance_tech_check_in/features/common/custom_header_bar.dart';
import 'package:alliance_tech_check_in/features/survey/toggle_selection_button.dart';
import 'package:alliance_tech_check_in/generated/i18n.dart';
import 'package:alliance_tech_check_in/locator.dart';
import 'package:alliance_tech_check_in/models/api/api_survey.dart';
import 'package:alliance_tech_check_in/services/api/api_service.dart';
import 'package:alliance_tech_check_in/services/api/auth_service.dart';
import 'package:alliance_tech_check_in/utils/pair.dart';
import 'package:alliance_tech_check_in/widgets/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alliance_tech_check_in/utils/extensions/text_ext.dart';
import 'package:alliance_tech_check_in/utils/extensions/date_ext.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SurveyScreen extends StatefulWidget {
  final SharedPreferences sharedPrefs;
  final AuthService _authService;
  final ApiService _apiService;

  SurveyScreen()
    : _authService = sl(),
      _apiService = sl(),
      sharedPrefs = sl();

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<SurveyScreen> {
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _temperatureController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  Map<int, bool> _responses = Map<int, bool>();
  Map<int, InfoState> _moreInfoState = Map<int, InfoState>();
  DateTime _exposedDate;
  DateTime _lastSubmittedDate;

  AnimationController _tempController;
  AnimationController _dateController;
  AnimationController _exposureController;
  AnimationController _resetController;
  Animation _tempAnimation;
  Animation _dateAnimation;
  Animation _exposureAnimation;
  Animation _resetAnimation;

  bool _uploading = false;

  Duration _animationDuration = const Duration(milliseconds: 500);

  final _formKey = GlobalKey<FormState>();

  Map<int, Pair<AnimationController, Animation>> _infoAnimationControllers = Map<int, Pair<AnimationController, Animation>>();

  void _resetState() {
    _exposedDate = null;
    _temperatureController.clear();
  }

  @override
  void initState() {
    super.initState();

    widget._apiService.init();
    var lastSubmitted = widget.sharedPrefs.getInt(lastSubmittedKey);
    if (lastSubmitted != null) {
      _lastSubmittedDate = DateTime.fromMillisecondsSinceEpoch(lastSubmitted);
    }

    _tempController = AnimationController(
      duration: _animationDuration,
      vsync: this
    );
    _tempAnimation = CurvedAnimation(parent: _tempController, curve: Curves.fastOutSlowIn);

    _dateController = AnimationController(
        duration: _animationDuration,
        vsync: this
    );
    _dateAnimation = CurvedAnimation(parent: _dateController, curve: Curves.fastOutSlowIn);

    _exposureController = AnimationController(
        duration: _animationDuration,
        vsync: this
    );
    _exposureAnimation = CurvedAnimation(parent: _exposureController, curve: Curves.fastOutSlowIn);
    _exposureController.forward();

    _resetController = AnimationController(
        duration: _animationDuration,
        vsync: this
    );
    _resetAnimation = CurvedAnimation(parent: _resetController, curve: Curves.fastOutSlowIn);


    var firstName = widget.sharedPrefs.getString(firstNameKey);
    var lastName = widget.sharedPrefs.getString(lastNameKey);
    _firstNameController = TextEditingController(text: firstName);
    _lastNameController = TextEditingController(text: lastName);
  }

  @override
  void dispose() {
    super.dispose();
    _tempController.dispose();
    _dateController.dispose();
    _exposureController.dispose();
    _resetController.dispose();
    _scrollController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _temperatureController.dispose();

    _infoAnimationControllers.forEach((key, value) {
      value.first.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(statusBarColor: AppColors.headerColor),
        child: Scaffold(
            appBar: CustomHeaderBar(
              height: 100,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 22, bottom: 8),
                        child: Image(
                            image: AssetImage("assets/alliancelogo.png"),
                            height: 50.0
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 22, bottom: 8, right: 8),
                      child: IconButton(
                        icon: Icon(
                          Icons.logout,
                          color: AppColors.darkTextColor,
                          size: 32,
                        ),
                        onPressed: () {
                          // show dialog
                          widget._authService.signOut().then((value) {
                            widget.sharedPrefs.clear().then((value) =>
                                Navigator.pushReplacementNamed(context, loginScreen)
                            );
                          });
                        }
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanDown: (_) {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Scrollbar(
                          isAlwaysShown: true,
                          controller: _scrollController,
                          child: ListView(
                            controller: _scrollController,
                            children: [
                              _createHeader(S.of(context).checkIn(DateTime.now().prettyPrint())),
                              _createPersonalInfo(),
                              SizedBox(height: 16),
                              _createQuestion(0, S.of(context).question1, info: S.of(context).question1Details, url: closeContactUrl),
                              _createQuestion(1, S.of(context).question2, showDatePicker: true, dateRequired: true),
                              _createQuestion(2, S.of(context).question3, info: S.of(context).question3Details, showOnFirst: true, url: symptomsUrl),
                              _createDisclaimer()
                            ],
                          ),
                        ),
                      ),
                      Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.backgroundColor,
                              ),
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(8, 16, 16, 24),
                                      child: Text(
                                        (!_uploading) ? S.of(context).submit : S.of(context).submitting,
                                        style: Theme.of(context).textTheme.headline4.toLight(),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _uploading,
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator()
                                      ),
                                    )
                                  ]
                              ),
                            ),
                            onTap: () {
                              //submit here
                              print(_responses);
                              var exposureDateInvalid = _responses[1] && _exposedDate == null;
                              var temp = _temperatureController.text.trim();
                              var tempValidator = double.parse(temp, (value) {
                                return null;
                              });
                              var tempInvalid = tempValidator == null;

                              if (_formKey.currentState.validate() && !exposureDateInvalid && !tempInvalid) {
                                print("Temp is: $tempValidator");

                                _tempController.reverse();
                                _dateController.reverse();

                                var maxScroll = _scrollController.position.maxScrollExtent;
                                if (maxScroll - _scrollController.position.pixels <= 75) {
                                  var firstname = _firstNameController.text.trim();
                                  var lastname = _lastNameController.text.trim();

                                  widget.sharedPrefs.setString(firstNameKey, firstname);
                                  widget.sharedPrefs.setString(lastNameKey, lastname);

                                  var apiSurvey = ApiSurvey.fromValues(
                                    firstname,
                                    lastname,
                                    temp,
                                    _responses[0],
                                    _responses[1],
                                    _exposedDate,
                                    _responses[2]
                                  );

                                  setState(() {
                                    _uploading = true;
                                  });

                                  widget._apiService.sendSurveyData(apiSurvey).then((result) {
                                    if (result) {
                                      widget.sharedPrefs.setInt(lastSubmittedKey, DateTime.now().millisecondsSinceEpoch);
                                      setState(() {
                                        _lastSubmittedDate = DateTime.now();
                                        _uploading = false;
                                        _resetState();
                                      });
                                      showResultDialog(context, true);
                                    }
                                    else {
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(content: Text(S.of(context).submit_error))
                                      );
                                      setState(() {
                                        _uploading = false;
                                      });
                                    }
                                  });
                                }
                                else {
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text(S.of(context).view_disclaimer), duration: const Duration(seconds: 1))
                                  );
                                  _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: _animationDuration, curve: Curves.easeOut);
                                }
                              }
                              else {
                                if (tempInvalid) {
                                  print("Temp invalid");
                                  _tempController.forward();
                                }
                                else {
                                  _tempController.reverse();
                                }

                                if (exposureDateInvalid) {
                                  print("Exposure date invalid $_exposedDate");
                                  _dateController.forward();
                                }
                                else {
                                  _dateController.reverse();
                                }
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text(S.of(context).responseEmpty)));
                              }
                            },
                          );
                        },
                      )
                    ],
                  )
              ),
            )
        )
    );
  }

  Widget _createPersonalInfo() {
    return Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 2),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createTextEntry(S.of(context).firstName, _firstNameController),
              _createTextEntry(S.of(context).lastName, _lastNameController),
              _createTempReading(),
            ],
          ),
        ),
    );
  }

  Widget _createTempReading() {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              S.of(context).currentTemp,
              style: Theme.of(context).textTheme.headline5.setColor(AppColors.headline)
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IntrinsicWidth(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: TextFormField(
                        controller: _temperatureController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: S.of(context).tempHint,
                          hintStyle: Theme.of(context).textTheme.headline5.setColor(AppColors.primaryColor).bigger(4),
                          contentPadding: EdgeInsets.all(4)
                        ),
                        style: Theme.of(context).textTheme.headline5.bigger(4),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: 8),
                    child: Text(
                      "\u00B0F",
                      style: Theme.of(context).textTheme.headline5.bigger(4)
                    ),
                  )
                ],
              ),
              SizeTransition(
                sizeFactor: _tempAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2, right: 8),
                  child: Text(
                    S.of(context).responseError,
                    style: Theme.of(context).textTheme.headline5.smaller(8).setColor(AppColors.error),
                  ),
                ),
              )
            ],
          )
        ],
      )
    );
  }

  Widget _createQuestion(int index, String text, {String info = "", String url = "", bool showOnFirst = false, bool showDatePicker = false, bool dateRequired = false}) {
    _responses.putIfAbsent(index, () => true);
    _moreInfoState.putIfAbsent(index, () => showOnFirst ? InfoState.FIRST : InfoState.HIDDEN);

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _createQuestionHeader(S.of(context).questionHeader(index + 1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: _createQuestionDetails(index, text, info, showDatePicker, url: url),
                  )
              ),
              ToggleSelectionButton(_responses[index], (value) {
                setState(() {
                  if (dateRequired) {
                    value ? _exposureController.forward() : _exposureController.reverse();
                  }
                  _responses[index] = value;
                });
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createMoreInfo(int index, {String info = "", String url = ""}) {
    var controller = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );
    var animation = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    _infoAnimationControllers.putIfAbsent(index, () => Pair(controller, animation));

    if (_moreInfoState[index] == InfoState.FIRST) {
      _setNextInfoState(index, InfoState.SHOWN);
    }

    return Column(
      children: [
        (info.isNotEmpty) ? GestureDetector(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
            child: Row(
              children: [
                Text(
                  _moreInfoState[index] == InfoState.SHOWN ? S.of(context).hideInfo : S.of(context).moreInfo,
                  style: Theme.of(context).textTheme.headline6.bigger(4),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: FaIcon(
                    _moreInfoState[index] == InfoState.SHOWN ? FontAwesomeIcons.angleUp : FontAwesomeIcons.angleDown,
                    color: AppColors.lightTextColor,
                    size: 16,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            _setNextInfoState(index, _moreInfoState[index] == InfoState.SHOWN ? InfoState.HIDDEN : InfoState.SHOWN);
          },
        ) : SizedBox(height: 0),
        SizeTransition(
            sizeFactor: _infoAnimationControllers[index].second,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan (
                    text: info,
                    style: Theme.of(context).textTheme.bodyText1.bigger(2).setColor(AppColors.primaryColor).copyWith(
                      decoration: TextDecoration.underline
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        if (await canLaunch(url)) {
                          launch(url);
                        }
                      }
                  ),
                  WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Icon(
                          Icons.link,
                          color: AppColors.primaryColor,
                          size: 13,
                        ),
                      ),
                  )
                ],
              ),
            ),
        )
      ],
    );
  }

  Widget _createHeader(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 2),
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        (_lastSubmittedDate == null) ? SizedBox(height: 0) : Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Text(
            S.of(context).lastCheckIn(DateFormat.yMMMd().add_jm().format(_lastSubmittedDate)),
            style: Theme.of(context).textTheme.headline5.toDark()
          )
        )
      ],
    );
  }

  Widget _createQuestionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget _createQuestionDetails(int index, String text, String info, bool showDatePicker, {String url = ""}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1.bigger(6).toDark()
        ),
        _createMoreInfo(index, info: info, url: url),
        SizeTransition(
          sizeFactor: _exposureAnimation,
          child: _createDatePicker(showDatePicker)
        )
      ],
    );
  }

  Widget _createDatePicker(bool enableDatePicker) {
    if (enableDatePicker) {
      return Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AllianceTheme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(2)
                    ),
                    child: Text(
                      _exposedDate == null ? S.of(context).selectExposureDate : _exposedDate.prettyPrint(),
                      style: Theme.of(context).textTheme.headline5.smaller(2).toLight(),
                    ),
                  ),
                  onTap: () {
                    if (Platform.isIOS) {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                              height: MediaQuery
                                  .of(context)
                                  .copyWith()
                                  .size
                                  .height / 3,
                              child: CupertinoDatePicker(
                                initialDateTime: DateTime.now(),
                                maximumDate: DateTime.now(),
                                mode: CupertinoDatePickerMode.date,
                                onDateTimeChanged: (DateTime value) {
                                  setState(() {
                                    _exposedDate = value;
                                  });
                                },
                              ),
                            );
                          }
                      );
                    }
                    else {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2015),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        setState(() {
                          _exposedDate = value;
                        });
                      });
                    }
                  },
                ),
              ),
              SizeTransition(
                sizeFactor: _dateAnimation,
                child: Text(
                  S.of(context).responseError,
                  style: Theme.of(context).textTheme.headline5.smaller(8).setColor(AppColors.error),
                ),
              )
            ],
          );
        }
      );
    }

    return SizedBox(height: 0);
  }

  Widget _createTextEntry(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, right: 8, top: 4),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.headline5.setColor(AppColors.headline),
          errorStyle: Theme.of(context).textTheme.headline5.smaller(8).setColor(AppColors.error),
          contentPadding: EdgeInsets.all(4)
        ),
        validator: _validateInput,
        style: Theme.of(context).textTheme.headline5.bigger(2),
      ),
    );
  }

  Widget _createDisclaimer() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 24, 16),
      child: Text(
        S.of(context).disclaimer,
        style: Theme.of(context).textTheme.headline6.setColor(AppColors.error),
        textAlign: TextAlign.justify,
      ),
    );
  }

  void _setNextInfoState(int index, InfoState nextState) {
    setState(() {
      if (nextState == InfoState.HIDDEN) {
        _infoAnimationControllers[index].first.reverse();
      }
      else {
        _infoAnimationControllers[index].first.forward();
      }
      _moreInfoState[index] = nextState;
    });
  }

  String _validateInput(String value) {
    if (value.isEmpty) {
      return S.of(context).responseError;
    }

    return null;
  }

  @override
  bool get wantKeepAlive => true;
}
