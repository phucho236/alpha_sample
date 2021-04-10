import 'package:after_layout/after_layout.dart';
import 'package:alpha_sample/base/builder/base.dart';
import 'package:alpha_sample/base/builder/base_bloc.dart';
import 'package:alpha_sample/base/builder/base_state.dart';
import 'package:alpha_sample/base/widget/base_consumer.dart';
import 'package:alpha_sample/models/internal/config.dart';
import 'package:alpha_sample/models/profile_model.dart';
import 'package:alpha_sample/my_app/locator.dart';
import 'package:alpha_sample/resources/strings.dart';
import 'package:alpha_sample/resources/styles.dart';
import 'package:alpha_sample/services/admod_service.dart';
import 'package:alpha_sample/services/fcm_notification_service.dart';
import 'package:alpha_sample/utils/validators_utils.dart';
import 'package:alpha_sample/views/forgot_password/forgot_password_page.dart';
import 'package:alpha_sample/views/home/home_page.dart';
import 'package:alpha_sample/views/login/login_bloc.dart';
import 'package:alpha_sample/views/register/register_page.dart';
import 'package:alpha_sample/widgets/container/app_bar_widget.dart';
import 'package:alpha_sample/widgets/text_form_field_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends BaseConsumerWidget {
  static const String routeName = "/LoginPage";

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends BaseConsumerState<LoginPage>
    with AfterLayoutMixin {
  final _fcm = locator<FcmNotificationService>();
  final _adMobService = locator<AdMobService>();
  final _globalKeyLoginPage = GlobalKey<FormState>();

  FeatureItem feature;
  var data;
  ProfileModel profileFaceBookModel;
  bool loginFaceBook = false;
  bool loginGoogle = false;
  bool loginApple = false;

  var textEditingControllerEmail =
      TextEditingController(text: "test@gmail.com");
  var textEditingControllerPassWord = TextEditingController(text: "123456");

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    configService.loginScreen.configs.forEach((item) {
      if (item.key == "login_facebook") loginFaceBook = item.value;
      if (item.key == "login_google") loginGoogle = item.value;
      if (item.key == "login_apple") loginApple = item.value;
    });
  }

  @override
  BaseBloc createBloc() => LoginBloc();

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    await _fcm.getFcmToken();
    if (!configService.ads.enableFeature) _adMobService.showBanner();
  }

  @override
  void handleListener(context, state) {
    super.handleListener(context, state);
    if (state is LoggedIn) {
      Navigator.pushNamed(context, HomePage.routeName,
          arguments: state.profileModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ASAppBar(showBack: false, title: loginLabel(context)),
      body: SingleChildScrollView(
        child: blocConsumer(context),
      ),
    );
  }

  @override
  Widget bodyContentView(BuildContext context, BaseState state) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: _globalKeyLoginPage,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 100),
                  TextFormFieldValidator(
                    globalKeyTextFormFieldPassWord: _globalKeyLoginPage,
                    hintText: Strings.emailLabel,
                    textEditingController: textEditingControllerEmail,
                    validator: (value) {
                      return checkEmail(value) ? null : errEmailLabel(context);
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormFieldValidator(
                    textEditingController: textEditingControllerPassWord,
                    hintText: passWordLabel(context),
                    globalKeyTextFormFieldPassWord: _globalKeyLoginPage,
                    isInputPass: true,
                    validator: (value) {
                      return checkPassWord(value)
                          ? null
                          : errPassLabel(context);
                    },
                  ),
                  SizedBox(height: 30),
                  RaisedButton(
                    onPressed: () {
                      if (_globalKeyLoginPage.currentState.validate()) {
                        Navigator.pushNamed(context, HomePage.routeName,
                            arguments: ProfileModel.empty);
                        _adMobService.hideBanner();
                      }
                    },
                    child: Container(
                      child: Center(child: Text(loginLabel(context))),
                      width: 300,
                    ),
                  ),
                  SizedBox(height: 15),
                  loginFaceBook && loginGoogle && loginApple
                      ? Text(
                          loginWithLabel(context),
                          style: Style.normalStFont
                              .copyWith(fontWeight: typeSemiBold),
                        )
                      : Container(),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      loginFaceBook ? _loginFacebookButton() : Container(),
                      loginGoogle ? _loginGoogleButton() : Container(),
                      loginApple ? _loginAppleButton() : Container(),
                      _loginZaloButton(),
                    ],
                  ),
                  _forgotPassword(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterPage.routeName);
                      },
                      child: Text(registerLabel(context)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginFacebookButton() {
    return RaisedButton(
      onPressed: () {
        _adMobService?.hideBanner();
        addEvent(LogInFaceBookEvent());
      },
      child: Text(Strings.loginWithFaceBook),
    );
  }

  Widget _loginGoogleButton() {
    return RaisedButton(
      onPressed: () {
        _adMobService.hideBanner();
        addEvent(LogInGoogleEvent());
      },
      child: Text(Strings.loginWithGoogle),
    );
  }

  Widget _loginZaloButton() {
    return RaisedButton(
      onPressed: () {
        _adMobService.hideBanner();
        addEvent(LogInZaloEvent());
      },
      child: Text(Strings.loginWithZalo),
    );
  }

  Widget _loginAppleButton() {
    return RaisedButton(
      onPressed: () {},
      child: Text(Strings.loginWithApple),
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, ForgotPasswordPage.routeName);
        },
        child: Text(forgotPassWordLabel(context)),
      ),
    );
  }
}
