import 'package:alpha_sample/resources/strings.dart';
import 'package:alpha_sample/resources/styles.dart';
import 'package:alpha_sample/views/login/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    // setItemMenu();
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Strings.splashScreen,
              style: Style.largeStFont.copyWith(fontSize: 36.0),
            ),
            SizedBox(height: 12.0),
            FlatButton(
              child: Text(openLoginLabel(context), style: Style.mediumStFont),
              onPressed: () =>
                  Navigator.pushNamed(context, LoginPage.routeName),
            ),
//TODO: Menu Left Icon
            // Builder(
            //   builder: (ctx) => GestureDetector(
            //     // child: Icon(
            //     //   Icons.menu,
            //     //   size: 35,
            //     //   // color: kColorWite,
            //     // ),
            //     child: Text("Menu Left"),
            //     onTap: () {
            //       isMenuRight
            //           ? Scaffold.of(ctx).openEndDrawer()
            //           : Scaffold.of(ctx).openDrawer();
            //     },
            //   ),
            // ),
            // SizedBox(height: 20),
            // Builder(
            //   builder: (ctx) => GestureDetector(
            //     // child: Icon(
            //     //   Icons.menu,
            //     //   size: 35,
            //     //   // color: kColorWite,
            //     // ),
            //     child: Text("Menu Right"),
            //     onTap: () {
            //       true
            //           ? Scaffold.of(ctx).openEndDrawer()
            //           : Scaffold.of(ctx).openDrawer();
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  TextStyle styleText1 = TextStyle(
    height: 1,
    color: Colors.white,
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  TextStyle styleText = TextStyle(
    height: 1,
    color: Colors.white,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );
}
