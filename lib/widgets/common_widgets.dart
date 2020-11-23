import 'package:alliance_tech_check_in/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:alliance_tech_check_in/utils/extensions/text_ext.dart';

void showSingleActionDialog(BuildContext context, String title, String message) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              title,
              style: Theme.of(context).textTheme.headline4.toDark()
          ),
          content: Text(
              message,
              style: Theme.of(context).textTheme.subtitle2.toDark()
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                  S.of(context).yes,
                  style: Theme.of(context).textTheme.button.toBold()
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
  );
}