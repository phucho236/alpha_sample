import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:alpha_sample/models/FQA/FQA_model.dart';
import 'package:alpha_sample/widgets/container/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/services.dart';

FQA data = new FQA.fromJson({
  'question': "What is the Central Limit Theorem and why is it important?",
  'answer':
      'Suppose that we are interested in estimating the average height among all people. Collecting data for every person in the world is impossible. While we can’t obtain a height measurement from everyone in the population, we can still sample some people. The question now becomes, what can we say about the average height of the entire population given a single sample. The Central Limit Theorem addresses this question exactly.'
});
FQA data1 = new FQA.fromJson({
  'question': "What is sampling? How many sampling methods do you know?",
  'answer':
      'Data sampling is a statistical analysis technique used to select, manipulate and analyze a representative subset of data points to identify patterns and trends in the larger data set being examined'
});
FQA data2 = new FQA.fromJson({
  'question': "What is the difference between type I vs type II error?",
  'answer':
      'A type I error occurs when the null hypothesis is true, but is rejected. A type II error occurs when the null hypothesis is false, but erroneously fails to be rejected'
});

class HelpPage extends StatefulWidget {
  static const String routeName = "/HelpPage";
  final List<FQA> listFQA;

  const HelpPage({Key key, this.listFQA}) : super(key: key);

  @override
  HelpPageState createState() => HelpPageState();
}

class HelpPageState extends State<HelpPage> with AfterLayoutMixin {
  Directory _downloadsDirectory;
  List<FQA> listFQA;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadConfig();
    List<FQA> mockupData = new List<FQA>();

    mockupData.add(data);
    mockupData.add(data1);
    mockupData.add(data2);

    listFQA = widget.listFQA != null ? widget.listFQA : mockupData;
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ASAppBar(
        showBack: true,
        // title: _configService.config.appName,
        title: 'FQA',
      ),
      body: Center(
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            ListView(
              physics: NeverScrollableScrollPhysics(),
              children: listFQA
                  .map(
                    (item) => ListTile(
                      isThreeLine: item.question != 'Flags',
                      subtitle: item.answer != null
                          ? Text(
                              item.answer,
                              style: answerStyle,
                            )
                          : Container(),
                      title: Text(item.question, style: questionStyle),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle answerStyle = TextStyle(
    color: Colors.black,
    fontSize: 14,
  );

  TextStyle questionStyle = TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic);
}
