import 'package:alpha_sample/base/builder/base.dart';
import 'package:alpha_sample/models/profile_model.dart';
import 'package:alpha_sample/my_app/locator.dart';
import 'package:alpha_sample/repositories/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_zalo_login/flutter_zalo_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginBloc extends BaseBloc {
  var repository = locator<UserRepository>();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      //'https://www.googleapis.com/auth/contacts.readonly', quyền truy cập danh bạ
    ],
  );

  LoginBloc() : super(DataLoadedState());

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is LogInFaceBookEvent) {
      yield* _mapFetchEmployeesFaceBook();
    }
    if (event is LogInGoogleEvent) {
      yield* _mapFetchEmployeesGoogle();
    }
    if (event is LogInZaloEvent) {
      yield* _mapFetchEmployeesZalo();
    }
  }

  Stream<BaseState> _mapFetchEmployeesFaceBook() async* {
    var _result = await repository.loginFaceBook();
    switch (_result.status) {
      case FacebookLoginStatus.loggedIn:
        try {
          var _profileFaceBook =
              await repository.getProfileFaceBook(_result.accessToken.token);
          yield LoggedIn(profileModel: _profileFaceBook);
        } on DioError catch (e) {
          yield ErrorState(message: e.toString());
        }

        break;
      case FacebookLoginStatus.cancelledByUser:
        yield CancelledByUser();
        break;
      case FacebookLoginStatus.error:
        yield LogInError(message: _result.errorMessage);
        break;
    }
  }

  Stream<BaseState> _mapFetchEmployeesGoogle() async* {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      print(googleSignInAccount);
      if (googleSignInAccount != null) {
        ProfileModel profileModel = ProfileModel(
          id: googleSignInAccount.id,
          name: googleSignInAccount.displayName,
          email: googleSignInAccount.email,
          firstName: "",
          lastName: "",
        );

        if (profileModel != null) yield LoggedIn(profileModel: profileModel);
      } else {
        yield LogInError(message: "err get profile google");
      }
    } catch (error) {
      yield LogInError(message: "err login Google");
    }
  }

  Stream<BaseState> _mapFetchEmployeesZalo() async* {
    try {
      ZaloLogin().init();
      ZaloLoginResult res = await ZaloLogin().logIn();
      if (res.userId != null) {
        ZaloProfileModel info = await ZaloLogin().getInfo();
        ProfileModel profileModel = ProfileModel(
          id: info.id,
          name: info.name,
          email: "",
          firstName: "",
          lastName: "",
        );

        if (profileModel != null) yield LoggedIn(profileModel: profileModel);
      } else {
        yield LogInError(message: "err get profile google");
      }
    } catch (error) {
      yield LogInError(message: "err login Google");
    }
  }
}

class LogInFaceBookEvent extends BaseEvent {
  @override
  String toString() => 'LogInFaceBookEven';
}

class LoggedIn extends BaseState {
  final ProfileModel profileModel;

  LoggedIn({@required this.profileModel});

  @override
  List<Object> get props => [profileModel];

  @override
  String toString() => 'LoggedIn:$profileModel';
}

class CancelledByUser extends BaseState {}

class LogInError extends BaseState {
  final String message;

  LogInError({this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "AuthenticationError: $message";
}

class LogInGoogleEvent extends BaseEvent {
  @override
  String toString() => 'LogInGoogleEvent';
}

class LogInZaloEvent extends BaseEvent {
  @override
  String toString() => 'LogInZaloEvent';
}
