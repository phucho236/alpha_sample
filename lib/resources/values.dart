import 'package:flutter/material.dart';

class ResourceDir {
  static const assetImages = "assets/images";
  static const assetIcons = "assets/icons";
  static const fonts = "fonts";
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}