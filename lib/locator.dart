import 'package:get_it/get_it.dart';
import 'package:packare_shipper/data/services/local/secure_storage_service.dart';
import 'package:packare_shipper/data/services/local/shared_preferences_service.dart';
import 'package:packare_shipper/router/app_router.dart';
import 'data/repositories/order_repository_impl.dart';
import 'data/services/api/order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/map_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'data/repositories/shipping_repository_impl.dart';
import 'data/services/api/auth_service.dart';
import 'data/services/api/image_service.dart';
import 'data/services/api/map_service.dart';
import 'data/services/api/user_service.dart';
import 'data/services/api/shipping_service.dart';
import 'data/services/api/websocket_service.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  print('Setting up GetIt locator...');

  // Register SharedPreferencesService
  try {
    final prefs = await SharedPreferences.getInstance();
    locator.registerLazySingleton<SharedPreferencesService>(
      () => SharedPreferencesService(prefs: prefs)..setupDefaults(),
    );
    print('SharedPreferencesService registered.');
  } catch (error) {
    print('Error getting SharedPreferences: $error');
  }

  // Register SecureStorageService
  try {
    locator.registerLazySingleton<SecureStorageService>(
      () => SecureStorageService(),
    );
    print('SecureStorageService registered.');
  } catch (error) {
    print('Error registering SecureStorageService: $error');
  }
  
  // Register ImageService
  try {
    locator.registerLazySingleton(() => ImageService());
    print('ImageService registered.');
  } catch (error) {
    print('Error registering ImageService: $error');
  }

  // Register WebSocketService
  try {
    locator.registerLazySingleton(() => WebSocketService());
    print('WebSocketService registered.');
  } catch (error) {
    print('Error registering WebSocketService: $error');
  }

  // Register AuthRepositoryImpl
  try {
    locator.registerLazySingleton(() => AuthService());
    locator.registerLazySingleton(() => AuthRepositoryImpl(
          authService: locator<AuthService>(),
          sharedPreferencesStorage: locator<SharedPreferencesService>(),
          secureStorage: locator<SecureStorageService>(),
        ));
    print('AuthRepositoryImpl registered.');
  } catch (error) {
    print('Error registering AuthRepositoryImpl: $error');
  }

  // Register UserRepositoryImpl
  try {
    locator.registerLazySingleton(() => UserService());
    locator.registerLazySingleton(() => UserRepositoryImpl(
          userApiService: locator<UserService>(),
          secureStorageService: locator<SecureStorageService>(),
        ));
    print('UserRepositoryImpl registered.');
  } catch (error) {
    print('Error registering UserRepositoryImpl: $error');
  }

  // Register ShippingRepositoryImpl
  try {
    locator.registerLazySingleton(() => ShippingService());
    locator.registerLazySingleton(() => ShippingRepositoryImpl(
          shipperService: locator<ShippingService>(),
          secureStorageService: locator<SecureStorageService>(),
          mapRepository: locator<MapRepositoryImpl>(),
          userRepository: locator<UserRepositoryImpl>(),
        ));
    print('ShipperRepositoryImpl registered.');
  } catch (error) {
    print('Error registering ShipperRepositoryImpl: $error');
  }

  // Register OrderRepositoryImpl
  try {
    locator.registerLazySingleton(() => OrderService());
    locator.registerLazySingleton(() => OrderRepositoryImpl(
          orderApiService: locator<OrderService>(),
          secureStorageService: locator<SecureStorageService>(),
        ));
    print('OrderRepositoryImpl registered.');
  } catch (error) {
    print('Error registering OrderRepositoryImpl: $error');
  }

  // Register MapRepoImpl
  try {
    locator.registerLazySingleton(() => MapService());
    locator.registerLazySingleton(() => MapRepositoryImpl(
          mapService: locator<MapService>(),
          secureStorageService: locator<SecureStorageService>(),
        ));
    print('MapRepositoryImpl registered.');
  } catch (error) {
    print('Error registering MapRepositoryImpl: $error');
  }

  print('GetIt locator setup complete.');
}
