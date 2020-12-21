import 'package:alliance_tech_check_in/config/theme.dart';
import 'package:alliance_tech_check_in/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:alliance_tech_check_in/utils/extensions/text_ext.dart';

void showSingleActionDialog(BuildContext context, String title, String message) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.headerColor,
          title: Text(
              title,
              style: Theme.of(context).textTheme.headline4.toLight()
          ),
          content: Text(
              message,
              style: Theme.of(context).textTheme.subtitle2.toLight()
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                  S.of(context).ok,
                  style: Theme.of(context).textTheme.button.setColor(AppColors.accent2).toBold().bigger(4)
              ),
              onPressed: () {
                // Navigator.pop(context);
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      }
  );
}

void showResultDialog(BuildContext context, bool success) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.headerColor,
          title: Center(
            child: Text(
                S.of(context).submit_complete_title,
                style: Theme.of(context).textTheme.headline4.toLight()
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  S.of(context).submit_complete_message,
                  style: Theme.of(context).textTheme.subtitle2.bigger(4).toLight()
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.good,
                  size: 128,
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                  S.of(context).ok,
                  style: Theme.of(context).textTheme.button.toLight().toBold().bigger(8)
              ),
              onPressed: () {
                // Navigator.pop(context);
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      }
  );
}