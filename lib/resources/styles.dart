import 'package:flutter/material.dart';

//type
const typeThin = FontWeight.w100;
const typeExtraLight = FontWeight.w200;
const typeLight = FontWeight.w300;
const typeNormal = FontWeight.w400;
const typeMedium = FontWeight.w500;
const typeSemiBold = FontWeight.w600;
const typeBold = FontWeight.w700;
const typeExtraBold = FontWeight.w800;

const fontFamily = 'Montserrat';

//color
class AppColors {
  static const Color main_background = Color(0xfff1f3f6);
  static const Color background = Color(0xFFF5F5F7);
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color chip_background = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const Color light_green = Color(0xFFA1ECBF);
  static const Color nearly_black = Color(0xFF213333);
  static const Color black = Colors.black;
  static const Color dark_grey = Color(0xFF313A44);
  static const Color dark_text = Color(0xFF253840);
  static const Color darker_text = Color(0xFF17262A);
  static const Color light_text = Color(0xFF4A6572);
  static const Color deactivated_text = Color(0xFF767676);
  static const Color dismissible_background = Color(0xFF364A54);
  static const Color blue = Colors.blue;
  static const Color blue_29 = Color(0xFF2980B9);
  static const Color nearly_dark_blue = Color(0xFF2633C5);
  static const Color nearly_blue = Color(0xFF00B6F0);
  static const Color red = Colors.red;
  static const Color border_grey = Color(0xFF707070);
  static const Color lightPrimary = Color(0xfffcfcff);
  static const Color lightBackground = Color(0xfffcfcff);
  static const Color lightAccent = Color(0xFF3B72FF);
  static Color transparent = Colors.transparent;

  static ThemeData lightTheme(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.apply(
          bodyColor: dark_grey,
          displayColor: dark_grey,
        );
    return ThemeData(
      fontFamily: fontFamily,
      cursorColor: dark_grey,
      canvasColor: background,
      // -------> Color bottom_navigation_bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
        elevation: 10,
        selectedLabelStyle: TextStyle(
            color: Color(0xFFA67926), fontFamily: 'Montserrat', fontSize: 14.0),
        unselectedLabelStyle: TextStyle(
            color: Colors.grey[600], fontFamily: 'Montserrat', fontSize: 12.0),
        selectedItemColor: Color(0xFFA67926),
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
      ),
      accentColor: dark_grey,
      primaryColor: dark_grey,
      colorScheme: ColorScheme.light(),
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        color: background,
        iconTheme: IconThemeData(color: dark_grey),
        textTheme: textTheme,
      ),
      iconTheme: IconThemeData(color: dark_grey),
      textTheme: textTheme,
      buttonTheme: ButtonThemeData(
        buttonColor: white,
        textTheme: ButtonTextTheme.primary,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: dark_text,
              // secondary will be the textColor, when the textTheme is set to accent
              secondary: white,
            ),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.apply(
          bodyColor: background,
          displayColor: background,
        );
    return ThemeData(
      fontFamily: fontFamily,
      cursorColor: background,
      canvasColor: dark_grey,
      // -------> Color bottom_navigation_bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
        elevation: 10,
        selectedLabelStyle: TextStyle(
            color: Color(0xFFA67926), fontFamily: 'Montserrat', fontSize: 14.0),
        unselectedLabelStyle: TextStyle(
            color: Colors.grey[600], fontFamily: 'Montserrat', fontSize: 12.0),
        selectedItemColor: Color(0xFFA67926),
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
      ),
      accentColor: background,
      primaryColor: background,
      colorScheme: ColorScheme.dark(),
      scaffoldBackgroundColor: dark_grey,
      appBarTheme: AppBarTheme(
        color: dark_grey,
        iconTheme: IconThemeData(color: background),
        textTheme: textTheme,
      ),
      iconTheme: IconThemeData(color: background),
      textTheme: textTheme,
      buttonTheme: ButtonThemeData(
        buttonColor: dark_grey,
        textTheme: ButtonTextTheme.primary,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: white,
              // secondary will be the textColor, when the textTheme is set to accent
              secondary: dark_text,
            ),
      ),
    );
  }
}

//size
const spacing = 0.27;
const smallSt = 12.0;
const normalSt = 14.0;
const mediumSt = 16.0;
const largeSt = 18.0;

//text style
class Style {
  static final smallStFont = const TextStyle(
    letterSpacing: spacing,
    fontSize: smallSt,
    fontWeight: typeNormal,
    fontFamily: fontFamily,
  );

  static final normalStFont = const TextStyle(
    letterSpacing: spacing,
    fontSize: normalSt,
    fontWeight: typeNormal,
    fontFamily: fontFamily,
  );

  static final mediumStFont = const TextStyle(
    letterSpacing: spacing,
    fontSize: mediumSt,
    fontWeight: typeNormal,
    fontFamily: fontFamily,
  );

  static final largeStFont = const TextStyle(
    letterSpacing: spacing,
    fontSize: largeSt,
    fontWeight: typeNormal,
    fontFamily: fontFamily,
  );

  static final smallStFontWhite = smallStFont.copyWith(color: Colors.white);
  static final normalStFontWhite = normalStFont.copyWith(color: Colors.white);
  static final mediumStFontWhite = mediumStFont.copyWith(color: Colors.white);
  static final largeStFontWhite = largeStFont.copyWith(color: Colors.white);

  static final smallStFontBlack = smallStFont.copyWith(color: AppColors.black);
  static final normalStFontBlack =
      normalStFont.copyWith(color: AppColors.black);
  static final mediumStFontBlack =
      mediumStFont.copyWith(color: AppColors.black);
  static final largeStFontBlack = largeStFont.copyWith(color: AppColors.black);

  static final smallStFontDarkText =
      smallStFont.copyWith(color: AppColors.dark_text);
  static final normalStFontDarkText =
      normalStFont.copyWith(color: AppColors.dark_text);
  static final mediumStFontDarkText =
      mediumStFont.copyWith(color: AppColors.dark_text);
  static final largeStFontDarkText =
      largeStFont.copyWith(color: AppColors.dark_text);

  static final smallStFontGrey = smallStFont.copyWith(color: AppColors.grey);
  static final normalStFontGrey = normalStFont.copyWith(color: AppColors.grey);
  static final mediumStFontGrey = mediumStFont.copyWith(color: AppColors.grey);
  static final largeStFontGrey = largeStFont.copyWith(color: AppColors.grey);
}
