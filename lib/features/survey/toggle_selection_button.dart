import 'package:alliance_tech_check_in/config/theme.dart';
import 'package:alliance_tech_check_in/generated/i18n.dart';
import 'package:alliance_tech_check_in/utils/pair.dart';
import 'package:flutter/material.dart';
import 'package:alliance_tech_check_in/utils/extensions/text_ext.dart';


class ToggleSelectionButton extends StatefulWidget {
  final Function(bool) callback;
  final bool initialValue;

  ToggleSelectionButton(this.initialValue, this.callback);

  @override
  _ToggleSelectionButtonState createState() => _ToggleSelectionButtonState();
}

class _ToggleSelectionButtonState extends State<ToggleSelectionButton> {
  bool _choice = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _choice = widget.initialValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _createButton(S.of(context).yes, true),
          _createButton(S.of(context).no, false),
        ],
      ),
    );
  }

  Widget _createButton(String text, bool value) {
    var colorPair = _getColorPair(value);

    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        child: Container(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
                color: _choice ? colorPair.first : colorPair.second,
                borderRadius: BorderRadius.all(Radius.circular(2))
            ),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1.bigger(3).toLight(),
            )
        ),
        onTap: () {
          setState(() {
            _choice = value;
            widget.callback(value);
          });
        },
      ),
    );
  }

  Pair _getColorPair(bool value) {
    if (value) {
      return Pair(AppColors.toggleSelected, AppColors.toggleDeselected);
    }
    else {
      return Pair(AppColors.toggleDeselected, AppColors.toggleSelected);
    }
  }
}