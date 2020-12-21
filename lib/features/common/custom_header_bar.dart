import 'package:alliance_tech_check_in/config/theme.dart';
import 'package:flutter/material.dart';

class CustomHeaderBar extends PreferredSize {
  final Widget child;
  final double height;
  final Color headerColor;

  const CustomHeaderBar({
    @required this.child,
    this.height = kToolbarHeight,
    this.headerColor = AppColors.headerColor
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: headerColor,
      alignment: Alignment.center,
      child: child,
    );
  }

}