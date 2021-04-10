import 'package:alpha_sample/base/builder/base_bloc.dart';
import 'package:alpha_sample/base/widget/base_builder.dart';
import 'package:alpha_sample/models/sample/post_model.dart';
import 'package:alpha_sample/my_app/locator.dart';
import 'package:alpha_sample/resources/styles.dart';
import 'package:alpha_sample/services/admod_service.dart';
import 'package:alpha_sample/views/sample/builder/sample_builder_bloc.dart';
import 'package:flutter/material.dart';

class SampleBuilderPage extends BaseBuilderWidget {
  static const String routeName = "/SampleBuilderPage";

  @override
  SampleBuilderState createState() => SampleBuilderState();
}

class SampleBuilderState extends BaseBuilderState<SampleBuilderPage>
    with AutomaticKeepAliveClientMixin<SampleBuilderPage> {
  final _adMobService = locator<AdMobService>();

  @override
  bool get isShowRefreshIndicator => true;

  @override
  BaseBloc createBloc() => SampleBuilderBloc();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return blocBuilder(context);
  }

  @override
  Widget bodyContentView(BuildContext context, data) {
    List<PostModel> employees = data as List<PostModel>;
    return bodyContent(employees);
  }

  Widget bodyContent(List<PostModel> employees) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: employees.length,
        padding: const EdgeInsets.all(12.0),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          List<Widget> widgets = [];
          if (index % 5 == 0
              //&&
              //configService.ads.enableFeature
              )
            widgets.add(
              Container(
                height: 350,
                child: _adMobService.nativeAdMob(
                  errLoadAds: SizedBox(
                    height: 0,
                  ),
                ),
              ),
            );
          widgets.add(Text('- id: ${employees[index].id}',
              style: Style.normalStFontDarkText));
          widgets.add(SizedBox(height: 6.0));
          widgets.add(Text('- userId: ${employees[index].userId}',
              style: Style.normalStFontDarkText));
          widgets.add(SizedBox(height: 6.0));
          widgets.add(Text('- Title: ${employees[index].title}',
              style: Style.normalStFontDarkText));
          widgets.add(Text('- Body: ${employees[index].body}',
              style: Style.normalStFontDarkText));
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widgets,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 12.0);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
