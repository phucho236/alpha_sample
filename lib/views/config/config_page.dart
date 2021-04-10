import 'package:alpha_sample/base/builder/app_event.dart';
import 'package:alpha_sample/base/builder/base_bloc.dart';
import 'package:alpha_sample/base/builder/base_state.dart';
import 'package:alpha_sample/base/widget/base_consumer.dart';
import 'package:alpha_sample/models/internal/config.dart';
import 'package:alpha_sample/resources/strings.dart';
import 'package:alpha_sample/views/config/config_bloc.dart';
import 'package:alpha_sample/widgets/container/app_bar_widget.dart';
import 'package:flutter/material.dart';

class ConfigPage extends BaseConsumerWidget {
  static const String routeName = "/ConfigPage";

  @override
  ConfigPageState createState() => ConfigPageState();
}

class ConfigPageState extends BaseConsumerState<ConfigPage> {
  @override
  BaseBloc createBloc() => ConfigBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ASAppBar(title: configLabel(context)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: blocConsumer(context),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: RaisedButton(
          onPressed: () {
            appBloc.add(UpdateConfigEvent(true, configService.config));
            Navigator.pop(context);
          },
          child: Text(saveLabel(context)),
        ),
      ),
    );
  }

  @override
  Widget bodyContentView(BuildContext context, BaseState state) {
    return bodyContent(context);
  }

  Widget bodyContent(BuildContext context) {
    return Column(
      children: <Widget>[
        loginScreenWidget(),
        featureItem(configService.localNotification),
        featureItem(configService.darkMode),
        featureItem(configService.multiLanguage),
        featureItem(configService.fcmNotification),
        featureItem(configService.qrCode),
        featureItem(configService.viewImage),
      ],
    );
  }

  Widget featureItem(FeatureItem item) {
    return Row(
      children: <Widget>[
        Expanded(child: Text(item.name)),
        Switch(
          value: item.enableFeature,
          onChanged: (value) {
            setState(() => item.enableFeature = !item.enableFeature);
          },
          activeTrackColor: Colors.black12,
          activeColor: Colors.black,
        )
      ],
    );
  }

  Widget loginScreenWidget() {
    List<Widget> widgets = [];
    widgets.add(Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(configService.loginScreen.name),
    ));
    configService.loginScreen.configs.asMap().forEach((index, item) {
      widgets.add(Container(
        padding: const EdgeInsets.only(left: 24.0),
        child: Row(
          children: <Widget>[
            Expanded(child: Text(item.key)),
            Switch(
              value: item.value,
              onChanged: (value) {
                setState(() => item.value = !item.value);
              },
              activeTrackColor: Colors.black12,
              activeColor: Colors.black,
            ),
          ],
        ),
      ));
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
