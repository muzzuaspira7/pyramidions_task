import 'package:flutter/material.dart';

class ScreenUtils {
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _baseWidth;
  static late double _baseHeight;

  /// Initialize ScreenUtils with current device size and design reference
  static void init(BuildContext context,
      {double baseWidth = 375, double baseHeight = 812}) {
    final size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
    _baseWidth = baseWidth;
    _baseHeight = baseHeight;
  }

  /// Width scaling relative to design width
  static double w(double value) => value * _screenWidth / _baseWidth;

  /// Height scaling relative to design height
  static double h(double value) => value * _screenHeight / _baseHeight;

  /// Radius / circular widgets scaling
  static double r(double value) => value * _screenWidth / _baseWidth;

  /// Font scaling
  static double sp(double fontSize) => fontSize * _screenWidth / _baseWidth;

  /// Fraction of screen width (0.0 to 1.0)
  static double sw(double fraction) => _screenWidth * fraction;

  /// Fraction of screen height (0.0 to 1.0)
  static double sh(double fraction) => _screenHeight * fraction;
}

/// Extension on num for easy usage
extension ScreenExtension on num {
  double get w => ScreenUtils.w(toDouble());
  double get h => ScreenUtils.h(toDouble());
  double get r => ScreenUtils.r(toDouble());
  double get sp => ScreenUtils.sp(toDouble());
  double get sw => ScreenUtils.sw(toDouble());
  double get sh => ScreenUtils.sh(toDouble());
}
