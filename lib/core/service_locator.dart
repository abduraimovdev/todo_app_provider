import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_app_provider/controllers/auth_controller.dart';
import 'package:todo_app_provider/controllers/connectivity_controller.dart';
import 'package:todo_app_provider/controllers/todo_controller.dart';
import 'package:todo_app_provider/repositories/todo_repository.dart';
import 'package:todo_app_provider/repositories/user_repository.dart';
import 'package:todo_app_provider/services/connectivity_service.dart';
import 'package:todo_app_provider/services/hive_service.dart';
import 'package:todo_app_provider/services/network_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  /// network
  final dio = Dio();
  final networkService = DioService(dio: dio);

  locator.registerLazySingleton<Network>(() {
    networkService.configuration(Api.baseUrl);
    return networkService;
  });

  // Secure Storage
  locator.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  /// repository
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(client: locator()));

  /// controller
  locator.registerFactory<AuthController>(() => AuthController(repository: locator()));

  /// repository
  locator.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(client: locator()));

  /// controller
  locator.registerFactory<TodoController>(() => TodoController(repository: locator()));

  // Connectivity Service
  locator.registerFactory<ConnectivityService>(() => ConnectivityService(connectivity: Connectivity()));


  //Connectivity
  locator.registerFactory<ConnectivityController>(() => ConnectivityController(checker: locator()));
}
