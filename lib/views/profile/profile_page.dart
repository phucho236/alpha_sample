import 'package:after_layout/after_layout.dart';
import 'package:alpha_sample/base/builder/base_bloc.dart';
import 'package:alpha_sample/base/builder/base_state.dart';
import 'package:alpha_sample/base/widget/base_consumer.dart';
import 'package:alpha_sample/my_app/locator.dart';
import 'package:alpha_sample/resources/strings.dart';
import 'package:alpha_sample/resources/styles.dart';
import 'package:alpha_sample/services/admod_service.dart';
import 'package:alpha_sample/views/config/config_page.dart';
import 'package:alpha_sample/views/images/images_page.dart';
import 'package:alpha_sample/views/profile/profile_bloc.dart';
import 'package:alpha_sample/views/qr_code/qr_code_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends BaseConsumerWidget {
  static const String routeName = "/ProfilePage";

  final dynamic profileModel;

  ProfilePage({this.profileModel});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends BaseConsumerState<ProfilePage>
    with AfterLayoutMixin {
  final _adMobService = locator<AdMobService>();
  bool enableQrCode = false;
  bool enableViewImage = false;

  @override
  void afterFirstLayout(BuildContext context) {
    enableQrCode = configService.qrCode.enableFeature;
    enableViewImage = configService.viewImage.enableFeature;
    if (configService.ads.enableFeature) _adMobService.showInterstitial();
  }

  @override
  BaseBloc createBloc() => LoginSuccessBloc();

  @override
  Widget build(BuildContext context) {
    return blocConsumer(context);
  }

  @override
  Widget bodyContentView(BuildContext context, BaseState state) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            infoProfile("id", widget.profileModel.id),
            infoProfile(nameUserLabel(context), widget.profileModel.name),
            infoProfile(
                lastNameUserLabel(context), widget.profileModel.lastName),
            infoProfile(
                firstNameUserLabel(context), widget.profileModel.firstName),
            infoProfile("${Strings.emailLabel}", widget.profileModel.email),
            SizedBox(height: 15.0),
            configService.qrCode.enableFeature
                ? qrCodeButton(context)
                : SizedBox(),
            SizedBox(height: 15.0),
            configService.viewImage.enableFeature
                ? viewImageButton(context)
                : SizedBox(),
          ],
        ),
        Positioned(
          right: 0.0,
          bottom: 0.0,
          child: GestureDetector(
            child: Container(
              height: 32.0,
              width: 32.0,
              color: AppColors.background,
            ),
            onLongPress: () =>
                Navigator.pushNamed(context, ConfigPage.routeName),
          ),
        )
      ],
    );
  }

  Widget infoProfile(String title, String info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text("$title: $info"),
        ),
        Divider(),
      ],
    );
  }

  Widget qrCodeButton(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      onPressed: () {
        Navigator.pushNamed(context, QRCodeLayout.routeName);
      },
      child: Text(qrCodeLabel(context)),
    );
  }

  Widget viewImageButton(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      onPressed: () {
        Navigator.pushNamed(context, ImagesPage.routeName);
      },
      child: Text(viewImagesLabel(context)),
    );
  }
}
