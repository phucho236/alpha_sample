import 'package:after_layout/after_layout.dart';
import 'package:alpha_sample/base/builder/base_bloc.dart';
import 'package:alpha_sample/base/builder/base_state.dart';
import 'package:alpha_sample/base/widget/base_consumer.dart';
import 'package:alpha_sample/models/internal/received_notification.dart';
import 'package:alpha_sample/models/sample/post_model.dart';
import 'package:alpha_sample/my_app/locator.dart';
import 'package:alpha_sample/resources/strings.dart';
import 'package:alpha_sample/services/local_notification_service.dart';
import 'package:alpha_sample/views/sample/consumer/sample_consumer_bloc.dart';
import 'package:flutter/material.dart';

class SampleConsumerPage extends BaseConsumerWidget {
  static const String routeName = "/SampleConsumerPage";

  @override
  SampleConsumerState createState() => SampleConsumerState();
}

class SampleConsumerState extends BaseConsumerState<SampleConsumerPage>
    with AfterLayoutMixin {
  final _localNotification = locator<LocalNotificationService>();
  List<PostModel> _employees = [];

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    ReceivedNotification notification = ReceivedNotification(
      title: "Alpha Sample",
      body: "Damn! This is amazing project...",
    );
    if (configService.localNotification.enableFeature) {
      _localNotification.scheduleLocalNotification(notification, 20);
      _localNotification.scheduleLocalNotification(notification, 40);
    }
  }

  @override
  BaseBloc createBloc() => SampleConsumerBloc();

  @override
  void handleListener(context, state) {
    super.handleListener(context, state);
    if (state is FetchEmployeesState) {
      if (state.data != null) _employees = state.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return blocConsumer(context);
  }

  @override
  Widget bodyContentView(BuildContext context, BaseState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          child: Text(fetchEmployeesLabel(context)),
          onPressed: () => addEvent(FetchEmployeesEvent()),
        ),
        _employees.length != 0
            ? Container(height: 12.0, color: Colors.red)
            : SizedBox(),
        _employees.length != 0
            ? Expanded(child: bodyContent(_employees))
            : SizedBox(),
        _employees.length != 0
            ? Container(height: 12.0, color: Colors.blue)
            : SizedBox(),
      ],
    );
  }

  Widget bodyContent(List<PostModel> employees) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(12.0),
      itemCount: employees.length,
      itemBuilder: (context, index) {
        String des = '- ${employees[index].title}\n- ${employees[index].body}';
        return Text(des);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
