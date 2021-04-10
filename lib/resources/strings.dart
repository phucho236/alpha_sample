import 'package:alpha_sample/services/app_localization.dart';

class Strings {
  static const appName = 'Alpha Sample';
  static const splashScreen = "Splash Screen";
  static const titleSampleBuilder = "Sample builder page";
  static const titleSampleConsumer = "Sample consumer page";
  static const adMobPage = "Admob Page";
  static const loginWithFaceBook = "Facebook";
  static const loginWithGoogle = "Google";
  static const loginWithZalo = "Zalo";
  static const loginWithApple = "Apple";
  static const oTPLabel = "OTP";
  static const emailLabel = "Email";
  static const errOTP = "length > 0 && OTP.length == 6";
}

String fetchEmployeesLabel(context) =>
    AppLocalizations.of(context).translate('fetch_employees_label');

String openLoginLabel(context) =>
    AppLocalizations.of(context).translate('open_login_label');

String homeLabel(context) =>
    AppLocalizations.of(context).translate('home_label');

String chooseLanguageLabel(context) =>
    AppLocalizations.of(context).translate('choose_language_label');

String loginWithLabel(context) =>
    AppLocalizations.of(context).translate('login_with_label');

String emptyLabel(context) =>
    AppLocalizations.of(context).translate('empty_label');

String retryLabel(context) =>
    AppLocalizations.of(context).translate('retry_label');

String loadingLabel(context) =>
    AppLocalizations.of(context).translate('loading_label');

String loginLabel(context) =>
    AppLocalizations.of(context).translate('login_label');

String registerLabel(context) =>
    AppLocalizations.of(context).translate('register_label');

String submitLabel(context) =>
    AppLocalizations.of(context).translate('submit_label');

String nextStepLabel(context) =>
    AppLocalizations.of(context).translate('next_step_label');

String viewImagesLabel(context) =>
    AppLocalizations.of(context).translate('view_images_label');

String step1Label(context) =>
    AppLocalizations.of(context).translate('step_1_label');

String step2Label(context) =>
    AppLocalizations.of(context).translate('step_2_label');

String step3Label(context) =>
    AppLocalizations.of(context).translate('step_3_label');

String qrCodeLabel(context) =>
    AppLocalizations.of(context).translate('qr_code_label');

String createQRCodeLabel(context) =>
    AppLocalizations.of(context).translate('create_qr_code_label');

String dataCreateQRCodeLabel(context) =>
    AppLocalizations.of(context).translate('data_create_qr_code_label');

String errCreateQRCodeLabel(context) =>
    AppLocalizations.of(context).translate('err_create_qr_code_label');

String passWordLabel(context) =>
    AppLocalizations.of(context).translate('password_label');

String confirmPassWordLabel(context) =>
    AppLocalizations.of(context).translate('confirm_password_label');

String nameUserLabel(context) =>
    AppLocalizations.of(context).translate('name_user_label');

String firstNameUserLabel(context) =>
    AppLocalizations.of(context).translate('first_name_label');

String lastNameUserLabel(context) =>
    AppLocalizations.of(context).translate('last_name_label');

String forgotPassWordLabel(context) =>
    AppLocalizations.of(context).translate('forgot_pass_word_label');

String errEmailLabel(context) =>
    AppLocalizations.of(context).translate('err_email_label');

String errPassLabel(context) =>
    AppLocalizations.of(context).translate('err_pass_label');

String passwordConfirmLabel(context) =>
    AppLocalizations.of(context).translate('err_pass_confirm_label');

String scanQRCodeLabel(context) =>
    AppLocalizations.of(context).translate('scan_qr_code_label');

String configLabel(context) =>
    AppLocalizations.of(context).translate('config_label');

String saveLabel(context) =>
    AppLocalizations.of(context).translate('save_label');
