import 'package:alpha_sample/widgets/dialog/app_dialog.dart' as AppDialog;
import 'package:flutter/material.dart';

Widget bodyChangeLanguageDialog(context, languageProvider) {
  List<Widget> languages = languageProvider.supportedLanguages
      .map(
        (object) => ListTile(
          dense: true,
          contentPadding: EdgeInsets.all(0.0),
          title: Text(
            object.language,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
            languageProvider.changeLanguage(object.locale);
          },
        ),
      )
      .toList();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text(
        "AppLocalizations.of(context).translate('choose_language')",
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0),
      ),
      Divider(),

    ],
  );
}

Future<void> buildChangeLanguageDialog(context, languageProvider) {
  return AppDialog.showDialog(
    context: context,
    builder: (BuildContext context) {
      return AppDialog.Dialog(
        isFullScreen: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: bodyChangeLanguageDialog(context, languageProvider),
      );
    },
  );
}
