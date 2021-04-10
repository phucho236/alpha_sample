import 'package:alpha_sample/repositories/user_repository.dart';
import 'package:alpha_sample/services/admod_service.dart';
import 'package:alpha_sample/services/config_service.dart';
import 'package:alpha_sample/services/fcm_notification_service.dart';
import 'package:alpha_sample/services/local_notification_service.dart';
import 'package:alpha_sample/services/network_service.dart';
import 'package:alpha_sample/services/socket_io_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void onSetupServiceLocator() {
  /// service
  locator.registerLazySingleton(() => ConfigService());
  locator.registerLazySingleton(() => NetworkService());
  locator.registerLazySingleton(() => SocketIOService());
  locator.registerLazySingleton(() => LocalNotificationService());
  locator.registerLazySingleton(() => FcmNotificationService());
  locator.registerLazySingleton(() => AdMobService());

  /// repository
  locator.registerLazySingleton(() => UserRepository());
}
