import 'dart:convert';

import 'package:alpha_sample/models/profile_model.dart';
import 'package:alpha_sample/models/sample/post_model.dart';
import 'package:alpha_sample/my_app/locator.dart';
import 'package:alpha_sample/repositories/base_repository.dart';
import 'package:alpha_sample/services/network_service.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class UserRepository extends BaseRepository {
  Future<List<PostModel>> fetchEmployees({int start}) async {
    var data = {"_start": start, "_limit": "4"};
    var response = await getList("posts?", param: data);
    List<PostModel> listPostModel = [];
    if (response != null) listPostModel = listPostModelFromJson(response.data);
    return listPostModel;
  }

  Future<dynamic> getProfileFaceBook(String token) async {
    final service = locator<NetworkService>();
    var result = await service.dio.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
    return ProfileModel.fromJson(jsonDecode(result.data));
  }

  Future<FacebookLoginResult> loginFaceBook() async {
    final facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final result = await facebookLogin.logIn(['email']);
    return result;
  }
}
