import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String prettyPrint() {
    return DateFormat.yMMMd().format(this);
  }
}