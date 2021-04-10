import 'package:after_layout/after_layout.dart';
import 'package:alpha_sample/base/builder/base.dart';
import 'package:alpha_sample/base/provider/app_theme_store.dart';
import 'package:alpha_sample/base/provider/language_store.dart';
import 'package:alpha_sample/my_app/locator.dart';
import 'package:alpha_sample/my_app/my_bloc_observer.dart';
import 'package:alpha_sample/resources/strings.dart';
import 'package:alpha_sample/resources/styles.dart';
import 'package:alpha_sample/services/app_localization.dart';
import 'package:alpha_sample/services/config_service.dart';
import 'package:alpha_sample/services/fcm_notification_service.dart';
import 'package:alpha_sample/services/local_notification_service.dart';
import 'package:alpha_sample/utils/common_utils.dart';
import 'package:alpha_sample/views/config/config_page.dart';
import 'package:alpha_sample/views/forgot_password/forgot_password_page.dart';
import 'package:alpha_sample/views/home/home_page.dart';
import 'package:alpha_sample/views/images/images_gesture.dart';
import 'package:alpha_sample/views/images/images_page.dart';
import 'package:alpha_sample/views/login/login_page.dart';
import 'package:alpha_sample/views/qr_code/create_qr_code_page.dart';
import 'package:alpha_sample/views/qr_code/qr_code_layout.dart';
import 'package:alpha_sample/views/map/googleMap.dart';
import 'package:alpha_sample/views/sample/builder/sample_builder_page.dart';
import 'package:alpha_sample/views/sample/consumer/sample_consumer_page.dart';
import 'package:alpha_sample/views/register/register_page.dart';
import 'package:alpha_sample/views/sample/paging/sample_paging_page.dart';
import 'package:alpha_sample/views/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'base/provider/menu_provider.dart';
import 'views/Q&A/helpPage.dart';
import 'views/download/downloadPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Provider.debugCheckInvalidValueType = null;
  onSetupServiceLocator();

  return mainCommon();
}

Future<void> mainCommon() async {
  final _localNotificationService = locator<LocalNotificationService>();
  await _localNotificationService.initialise();

  var myApp = MultiBlocProvider(
    providers: [
      BlocProvider<AppBloc>(create: (context) => AppBloc()),
    ],
    child: MyApp(
      configService: locator<ConfigService>(),
      localNotificationService: _localNotificationService,
      fcmNotificationService: locator<FcmNotificationService>(),
    ),
  );

  runApp(myApp);
}

class MyApp extends StatefulWidget {
  final ConfigService configService;
  final LocalNotificationService localNotificationService;
  final FcmNotificationService fcmNotificationService;

  const MyApp({
    Key key,
    @required this.configService,
    @required this.localNotificationService,
    @required this.fcmNotificationService,
  }) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with AfterLayoutMixin {
  // This widget is the root of your application.
  // Create [bloc, provider, store] final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final AppThemeStore _appThemeStore = AppThemeStore();
  final LanguageStore _languageStore = LanguageStore();

  ConfigService get _configService => widget.configService;

  LocalNotificationService get _localNotification =>
      widget.localNotificationService;

  FcmNotificationService get _fcm => widget.fcmNotificationService;

  /// load service expect time ~1.5s
  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    debugPrint('$runtimeType start: ${DateTime.now()}');
    await _configService.loadConfig;
    await _localNotification
        .configureDidReceiveLocalNotificationSubject(context);
    await _localNotification.configureSelectNotificationSubject();
    await _fcm.initialise();
    await handlingDevicesID();
    debugPrint('$runtimeType end: ${DateTime.now()}');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppThemeStore>(create: (_) => _appThemeStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
        Provider<MenuProvider>(create: (_) => MenuProvider()),
      ],
      child: GestureDetector(
        onTap: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        },
        child: Observer(
          name: "global-observer",
          builder: (context) {
            return MaterialApp(
              title: Strings.appName,
              onGenerateRoute: getRoute,
              debugShowCheckedModeBanner: true,
              locale: Locale(_languageStore.locale),
              supportedLocales: _languageStore.supportedLanguages
                  .map((language) => Locale(language.locale, language.code))
                  .toList(),
              theme: _appThemeStore.darkMode
                  ? AppColors.darkTheme(context)
                  : AppColors.lightTheme(context),
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: SplashPage(),
            );
          },
        ),
      ),
    );
  }

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.routeName:
        return _buildMaterialRoute(settings, LoginPage());
      case HomePage.routeName:
        return _buildMaterialRoute(
            settings, HomePage(profileModel: settings.arguments));
      case SampleBuilderPage.routeName:
        return _buildMaterialRoute(settings, SampleBuilderPage());
      case SamplePagingPage.routeName:
        return _buildMaterialRoute(settings, SamplePagingPage());
      case SampleConsumerPage.routeName:
        return _buildMaterialRoute(settings, SampleConsumerPage());
      case CreateQRCodePage.routeName:
        return _buildMaterialRoute(settings, CreateQRCodePage());
      case QRCodeLayout.routeName:
        return _buildMaterialRoute(settings, QRCodeLayout());
      case ImagesPage.routeName:
        return _buildMaterialRoute(settings, ImagesPage());
      case RegisterPage.routeName:
        return _buildMaterialRoute(settings, RegisterPage());
      case ImagesGesture.routeName:
        return _buildMaterialRoute(
            settings, ImagesGesture(urlImages: settings.arguments));
      case ForgotPasswordPage.routeName:
        return _buildMaterialRoute(settings, ForgotPasswordPage());
      case ConfigPage.routeName:
        return _buildMaterialRoute(settings, ConfigPage());
      case MapPage.routeName:
        return _buildMaterialRoute(settings, MapPage());
      case HelpPage.routeName:
        return _buildMaterialRoute(settings, HelpPage());
      case DownloadPage.routeName:
        return _buildMaterialRoute(settings, DownloadPage());
      default:
        return null;
    }
  }

  MaterialPageRoute _buildMaterialRoute(
      RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }

  Route _buildPageRoute(RouteSettings settings, Widget builder) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => builder,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    _localNotification.dispose();
    super.dispose();
  }
}
