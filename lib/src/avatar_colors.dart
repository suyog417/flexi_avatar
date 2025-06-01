import 'package:flutter/material.dart';

class AvatarColors {
  final Color? backgroundColor;
  final Color? textColor;
  final Gradient? gradient;

  const AvatarColors({
    this.backgroundColor,
    this.textColor,
    this.gradient,
  });

  Color get effectiveBackgroundColor {
    return gradient != null
        ? Colors.transparent
        : backgroundColor ?? _defaultBackgroundColor;
  }

  Color get effectiveTextColor {
    return textColor ?? _defaultTextColor;
  }

  static Color get _defaultBackgroundColor => Colors.blueGrey;
  static Color get _defaultTextColor => Colors.white;
}