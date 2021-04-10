import 'package:alpha_sample/base/provider/app_theme_store.dart';
import 'package:alpha_sample/base/provider/language_store.dart';
import 'package:alpha_sample/models/internal/language.dart';
import 'package:alpha_sample/resources/strings.dart';
import 'package:alpha_sample/resources/styles.dart';
import 'package:flutter/material.dart';

class ActionChangeTheme extends StatelessWidget {
  final AppThemeStore appThemeStore;

  const ActionChangeTheme(this.appThemeStore);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.brightness_5),
      onPressed: () {
        appThemeStore.changeBrightnessToDark(!appThemeStore.darkMode);
      },
    );
  }
}

class ActionChangeLanguage extends StatelessWidget {
  final LanguageStore languageStore;

  const ActionChangeLanguage(this.languageStore);

  @override
  Widget build(BuildContext context) {
    var menus = List<PopupMenuEntry<Language>>();
    menus.add(PopupMenuItem(
      textStyle: Style.normalStFontDarkText,
      child: Text(chooseLanguageLabel(context)),
    ));
    menus.add(PopupMenuDivider(height: 2));
    languageStore.supportedLanguages.forEach((item) {
      menus.add(
        PopupMenuItem(
          value: item,
          textStyle: Style.normalStFontDarkText,
          child: Text(item.language),
        ),
      );
    });

    return PopupMenuButton<Language>(
      itemBuilder: (context) => menus,
      icon: Icon(Icons.translate),
      offset: Offset(0, 100),
      onSelected: (Language lg) => languageStore.changeLanguage(lg.locale),
    );
  }
}

class ASAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool showBack;
  final Widget leading;
  final String title;
  final Widget bottom;
  final Function onBackPressed;
  final bool showShadow;
  final List<Widget> actions;

  const ASAppBar({
    this.height,
    this.showBack = true,
    this.leading,
    this.title,
    this.bottom,
    this.onBackPressed,
    this.showShadow = true,
    this.actions,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(this.height == null ? 56.0 : this.height);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0.0, -2.0),
              blurRadius: 3.0,
              spreadRadius: 1.0,
            )
          ],
        ),
        child: buildAppBar(context, actions),
      ),
    );
  }

  Widget buildAppBar(BuildContext context, List<Widget> actions) {
    return AppBar(
      elevation: 0.0,
      actions: actions,
      centerTitle: true,
      bottom: this.bottom,
      leading: buildLeading(context),
      title: Text(this.title == null ? "" : this.title),
    );
  }

  Widget buildLeading(BuildContext context) {
    if (this.leading != null) return this.leading;
    if (this.showBack == false) return Container();

    return Navigator.canPop(context)
        ? IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => this.onBackPressed != null
                ? this.onBackPressed()
                : Navigator.of(context).pop(),
          )
        : null;
  }
}
