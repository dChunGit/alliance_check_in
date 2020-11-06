import 'package:alliance_tech_check_in/config/theme.dart';
import 'package:flutter/material.dart';

extension TextExt on TextStyle {
  TextStyle toLight() {
    return this.apply(color: AppColors.darkTextColor);
  }

  TextStyle toDark() {
    return this.apply(color: AppColors.lightTextColor);
  }

  TextStyle setColor(Color newColor) {
    return this.apply(color: newColor);
  }

  TextStyle bigger(double size) {
    return this.copyWith(fontSize: this.fontSize + size);
  }

  TextStyle smaller(double size) {
    return this.copyWith(fontSize: this.fontSize - size);
  }

  TextStyle toBold() {
    return this.copyWith(fontWeight: FontWeight.bold);
  }

  TextStyle toNormal() {
    return this.copyWith(fontWeight: FontWeight.normal);
  }

  TextStyle toThin() {
    return this.copyWith(fontWeight: FontWeight.w200);
  }
}