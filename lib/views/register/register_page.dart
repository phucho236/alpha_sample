import 'package:alpha_sample/base/builder/base_bloc.dart';
import 'package:alpha_sample/base/builder/base_state.dart';
import 'package:alpha_sample/base/widget/base_consumer.dart';
import 'package:alpha_sample/resources/strings.dart';
import 'package:alpha_sample/utils/validators_utils.dart';
import 'package:alpha_sample/views/register/register_bloc.dart';
import 'package:alpha_sample/widgets/container/app_bar_widget.dart';
import 'package:alpha_sample/widgets/text_form_field_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends BaseConsumerWidget {
  static const String routeName = "/RegisterPage";

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseConsumerState<RegisterPage> {
  final _globalKeyRegisterPage = GlobalKey<FormState>();

  TextEditingController textEditingControllerEmail =
      new TextEditingController();
  TextEditingController textEditingControllerPassWord =
      new TextEditingController();
  TextEditingController textEditingControllerConfirmPassWord =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ASAppBar(title: registerLabel(context)),
      body: blocConsumer(context),
    );
  }

  @override
  Widget bodyContentView(BuildContext context, BaseState state) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: _globalKeyRegisterPage,
            child: Column(
              children: [
                TextFormFieldValidator(
                  globalKeyTextFormFieldPassWord: _globalKeyRegisterPage,
                  hintText: Strings.emailLabel,
                  textEditingController: textEditingControllerEmail,
                  validator: (value) {
                    return checkEmail(value) ? null : errEmailLabel(context);
                  },
                ),
                SizedBox(height: 12.0),
                TextFormFieldValidator(
                  textEditingController: textEditingControllerPassWord,
                  hintText: passWordLabel(context),
                  globalKeyTextFormFieldPassWord: _globalKeyRegisterPage,
                  isInputPass: true,
                  validator: (value) {
                    return checkPassWord(value) ? null : errPassLabel(context);
                  },
                ),
                SizedBox(height: 12.0),
                TextFormFieldValidator(
                  textEditingController: textEditingControllerConfirmPassWord,
                  hintText: confirmPassWordLabel(context),
                  globalKeyTextFormFieldPassWord: _globalKeyRegisterPage,
                  isInputPass: true,
                  validator: (value) {
                    return checkPassWord(value)
                        ? null
                        : passwordConfirmLabel(context);
                  },
                ),
                SizedBox(height: 36.0),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      if (_globalKeyRegisterPage.currentState.validate()) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(submitLabel(context)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  BaseBloc createBloc() => RegisterBloc();
}
