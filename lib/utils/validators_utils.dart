import 'package:validators/validators.dart';

bool checkEmail(String email) {
  return isEmail(email) ? true : false;
}

bool checkOTP(String OTP) {
  return (OTP.length > 0 && OTP.length == 6) ? true : false;
}

bool checkDataGenQRCode(String data) {
  return data.length != 0 && data.length <= 40 ? true : false;
}

bool checkPassWord(String password) {
  if (password != null &&
      password != "" &&
      password.length >= 6 &&
      password.length < 15) {
    return true;
  }
  return false;
}

bool checkTheSamePassWord(String password, String confirmPassword) {
  if (password == confirmPassword) {
    return true;
  }
  return false;
}
