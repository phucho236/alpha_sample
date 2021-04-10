import 'package:alpha_sample/resources/strings.dart';
import 'package:flutter/material.dart';

class ProgressIndicators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              strokeWidth: 4.0,
            ),
            SizedBox(width: 18.0),
            Text(loadingLabel(context)),
          ],
        ),
      ),
    );
  }
}
