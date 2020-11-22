import 'package:alliance_tech_check_in/config/theme.dart';
import 'package:alliance_tech_check_in/features/common/custom_header_bar.dart';
import 'package:alliance_tech_check_in/features/survey/toggle_selection_button.dart';
import 'package:alliance_tech_check_in/generated/i18n.dart';
import 'package:alliance_tech_check_in/locator.dart';
import 'package:alliance_tech_check_in/repositories/auth/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alliance_tech_check_in/utils/extensions/text_ext.dart';

class SurveyScreen extends StatefulWidget {
  final AuthRepository _authService;

  SurveyScreen()
      :_authService = sl();

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  Map<String, TextEditingController> dynamicTextFieldControllers = Map<String, TextEditingController>();
  ScrollController _scrollController = ScrollController();
  Map<int, bool> responses = Map<int, bool>();
  DateTime exposedDate;

  final _formKey = GlobalKey<FormState>();

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
                child: Image(
                  image: AssetImage("assets/hiprlogo.png"),
                  height: 30.0
                ),
              ),
            ),
            body: Container(
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
                            _createHeader("Personal Information"),
                            _createPersonalInfo(),
                            SizedBox(height: 16),
                            _createHeader("Sign In Information"),
                            _createQuestion(0, S.of(context).question1, "the centers"),
                            _createQuestion(1, S.of(context).question2, null),
                            _createQuestion(2, S.of(context).question3, null),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AllianceTheme.of(context).primaryColor,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "SUBMIT",
                                  style: Theme.of(context).textTheme.headline4.toLight(),
                                ),
                              ),
                            ]
                          ),
                        ),
                      ),
                      onTap: () {
                          //submit here
                      },
                    )
                  ],
                )
            )
        )
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Divider(
        height: 5,
        indent: 8,
        endIndent: 8,
        thickness: 2,
        color: AppColors.backgroundOutline,
      ),
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
              _createTextEntry("First name", TextEditingController()),
              _createTextEntry("Last name", TextEditingController()),
            ],
          ),
        ),
    );
  }

  Widget _createQuestion(int index, String text, String info) {
    responses.putIfAbsent(index, () => false);

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _createQuestionHeader("Question ${index + 1}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: _createQuestionText(text),
                  )
              ),
              ToggleSelectionButton((value) {
                setState(() {
                  responses[index] = value;
                });
              }),
            ],
          ),
          (info != null) ? GestureDetector(
            child: Text("more info"),
            onTap: () {
              // open dialog
            },
          ) : SizedBox(width: 0, height: 0),
          (exposedDate != null) ? Text(
            "Date here"
          ) : SizedBox(width: 0, height: 0)
        ],
      )
    );
  }

  Widget _createHeader(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 2),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline4,
      ),
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

  Widget _createQuestionText(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText1.bigger(4)
    );
  }

  Widget _createTextEntry(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
          child: TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: labelText
            ),
            validator: _validateInput,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ),
    );
  }

  String _validateInput(String value) {
    if (value.isEmpty) {
      return "Response required";
    }

    return null;
  }
}
