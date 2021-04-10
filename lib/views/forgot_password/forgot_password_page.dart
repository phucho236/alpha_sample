import 'package:alpha_sample/base/builder/base_bloc.dart';
import 'package:alpha_sample/base/builder/base_state.dart';
import 'package:alpha_sample/base/widget/base_consumer.dart';
import 'package:alpha_sample/resources/strings.dart';
import 'package:alpha_sample/utils/validators_utils.dart';
import 'package:alpha_sample/views/forgot_password/forgot_password_bloc.dart';
import 'package:alpha_sample/widgets/container/app_bar_widget.dart';
import 'package:alpha_sample/widgets/text_form_field_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends BaseConsumerWidget {
  static const String routeName = "ForgotPasswordPage";

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends BaseConsumerState<ForgotPasswordPage> {
  int _currentStep = 0;
  final _globalKeyForgotPassWordPage1 = GlobalKey<FormState>();
  final _globalKeyForgotPassWordPage2 = GlobalKey<FormState>();
  final _globalKeyForgotPassWordPage3 = GlobalKey<FormState>();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerOTP = TextEditingController();
  TextEditingController textEditingControllerPassWord = TextEditingController();
  TextEditingController textEditingControllerPassWordConfirm =
      TextEditingController();
  bool hidePassWord = true;
  bool hideConfirmPassWord = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ASAppBar(title: "Forgot Password"),
      body: blocConsumer(context),
    );
  }

  List<Step> _mySteps() {
    List<Step> _step = [
      Step(
        title: Text(step1Label(context)),
        content: Form(
          key: _globalKeyForgotPassWordPage1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormFieldValidator(
                globalKeyTextFormFieldPassWord: _globalKeyForgotPassWordPage1,
                hintText: Strings.emailLabel,
                textEditingController: textEditingControllerEmail,
                validator: (value) {
                  return checkEmail(value) ? null : errEmailLabel(context);
                },
              ),
              FlatButton(
                onPressed: () {
                  print(_globalKeyForgotPassWordPage1.currentState.validate());
                  if (_globalKeyForgotPassWordPage1.currentState.validate()) {
                    setState(() {
                      _currentStep = 1;
                    });
                  }
                },
                child: Text(
                  nextStepLabel(context),
                ),
              ),
            ],
          ),
        ),
        isActive: _currentStep == 0,
      ),
      Step(
        title: Text(step2Label(context)),
        content: Form(
          key: _globalKeyForgotPassWordPage2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormFieldValidator(
                globalKeyTextFormFieldPassWord: _globalKeyForgotPassWordPage2,
                hintText: Strings.oTPLabel,
                textEditingController: textEditingControllerOTP,
                validator: (value) {
                  return checkOTP(value) ? null : Strings.errOTP;
                },
              ),
              FlatButton(
                onPressed: () async {
                  if (_globalKeyForgotPassWordPage2.currentState.validate()) {
                    setState(() {
                      _currentStep = 2;
                      // return;
                    });
                  }
                },
                child: Text(
                  nextStepLabel(context),
                ),
              ),
            ],
          ),
        ),
        isActive: _currentStep == 1,
      ),
      Step(
        title: Text(step3Label(context)),
        content: Form(
          key: _globalKeyForgotPassWordPage3,
          child: Column(
            children: <Widget>[
              TextFormFieldValidator(
                globalKeyTextFormFieldPassWord: _globalKeyForgotPassWordPage3,
                hintText: passWordLabel(context),
                textEditingController: textEditingControllerPassWord,
                isInputPass: true,
                validator: (value) {
                  return checkPassWord(value) ? null : errPassLabel(context);
                },
              ),
              TextFormFieldValidator(
                globalKeyTextFormFieldPassWord: _globalKeyForgotPassWordPage3,
                hintText: confirmPassWordLabel(context),
                textEditingController: textEditingControllerPassWordConfirm,
                isInputPass: true,
                validator: (value) {
                  return checkPassWord(value)
                      ? null
                      : passwordConfirmLabel(context);
                },
              ),
              FlatButton(
                onPressed: () {
                  if (_globalKeyForgotPassWordPage3.currentState.validate()) {
                    if (checkTheSamePassWord(textEditingControllerPassWord.text,
                        textEditingControllerPassWordConfirm.text)) {
                      Navigator.pop(context);
                    } else {}
                  }
                },
                child: Text(
                  submitLabel(context),
                ),
              )
            ],
          ),
        ),
        isActive: _currentStep == 2,
      )
    ];
    return _step;
  }

  @override
  Widget bodyContentView(BuildContext context, BaseState state) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Stepper(
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Row(
                children: <Widget>[
                  Visibility(
                    visible: false,
                    child: FlatButton(
                      onPressed: onStepContinue,
                      child: null,
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: FlatButton(
                      onPressed: onStepCancel,
                      child: const Text(''),
                    ),
                  ),
                ],
              );
            },
            steps: _mySteps(),
            currentStep: _currentStep,
            type: StepperType.vertical,
          ),
        ],
      ),
    );
  }

  @override
  BaseBloc createBloc() => ForgotPassWordBloc();
}
