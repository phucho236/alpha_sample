import 'package:alpha_sample/base/builder/base.dart';
import 'package:alpha_sample/resources/strings.dart';
import 'package:flutter/material.dart';

Widget errorView(BuildContext context, ErrorState state, Function onReload) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(16),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(state.message.toString(), textAlign: TextAlign.center),
          SizedBox(height: 18),
          FlatButton(child: Text(retryLabel(context)), onPressed: onReload),
        ],
      ),
    ),
  );
}
