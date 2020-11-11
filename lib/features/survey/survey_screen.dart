import 'package:alliance_tech_check_in/config/theme.dart';
import 'package:alliance_tech_check_in/features/common/custom_header_bar.dart';
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
  Map<int, bool> responses = Map<int, bool>();
  DateTime exposedDate;

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //3 questions
                    _createQuestion(0, "close contact", "the centers"),
                    _createQuestion(1, "exposed", null),
                    _createQuestion(2, "symptoms adfs asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asd f", null),

                  ],
                )
            )
        )
    );
  }

  Widget _createQuestion(int index, String text, String info) {
    responses.putIfAbsent(index, () => false);

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Question ${index + 1}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text(text)),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: responses[index] ? Colors.pink : Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(2))
                        ),
                        child: Text("no")
                      ),
                      onTap: () {
                        setState(() {
                          responses[index] = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: responses[index] ? Colors.blue : Colors.pink,
                            borderRadius: BorderRadius.all(Radius.circular(2))
                        ),
                        child: Text("yes")
                      ),
                      onTap: () {
                        setState(() {
                          responses[index] = true;
                        });
                      },
                    ),
                  ),
                ],
              )
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
}
