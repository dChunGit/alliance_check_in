import 'package:alliance_tech_check_in/services/api/api_service.dart';
import 'package:alliance_tech_check_in/services/api/api_service_impl.dart';
import 'package:alliance_tech_check_in/services/api/auth_service.dart';
import 'package:alliance_tech_check_in/services/api/auth_service_impl.dart';
import 'package:alliance_tech_check_in/services/api/auth_storage_service.dart';
import 'package:alliance_tech_check_in/services/api/auth_storage_service.dart';
import 'package:alliance_tech_check_in/services/network/network_status.dart';
import 'package:alliance_tech_check_in/services/network/network_status_impl.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<NetworkStatus>(() => NetworkStatusImpl(DataConnectionChecker()));

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //  Repositories
  //  Api Repository
  sl.registerLazySingleton<ApiService>(() => ApiServiceImpl());
  sl.registerLazySingleton<AuthService>(() => AuthServiceImpl());
}