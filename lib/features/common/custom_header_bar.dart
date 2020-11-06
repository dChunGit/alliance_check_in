import 'package:alliance_tech_check_in/config/theme.dart';
import 'package:flutter/material.dart';

class CustomHeaderBar extends PreferredSize {
  final Widget child;
  final double height;

  const CustomHeaderBar({
    @required this.child,
    this.height = kToolbarHeight
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: AppColors.headerColor,
      alignment: Alignment.centerLeft,
      child: child,
    );
  }

}