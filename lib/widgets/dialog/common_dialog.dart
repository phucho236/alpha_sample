import 'package:alpha_sample/widgets/dialog/app_dialog.dart' as AppDialog;
import 'package:flutter/material.dart';

Future<void> showWaitingDialog(context) {
  return AppDialog.showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppDialog.Dialog(
          isFullScreen: false,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: CircularProgressIndicator(),
        );
      }
  );
}