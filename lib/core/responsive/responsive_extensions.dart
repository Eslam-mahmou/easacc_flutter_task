import 'package:flutter/material.dart';

extension ResponsiveExtensions on BuildContext {
  double widthPct(double percentage) {
    return MediaQuery.of(this).size.width * percentage;
  }

  double heightPct(double percentage) {
    return MediaQuery.of(this).size.height * percentage;
  }

  double fontPct(double percentage) {
    final screenWidth = MediaQuery.of(this).size.width;
    return screenWidth * percentage;
  }
}




