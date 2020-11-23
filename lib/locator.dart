import 'package:alliance_tech_check_in/repositories/api/api_repository.dart';
import 'package:alliance_tech_check_in/repositories/api/api_repository_impl.dart';
import 'package:alliance_tech_check_in/repositories/network/network_status.dart';
import 'package:alliance_tech_check_in/repositories/network/network_status_impl.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<NetworkStatus>(() => NetworkStatusImpl(DataConnectionChecker()));

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //  Repositories
  //  Api Repository
  sl.registerLazySingleton<ApiRepository>(() => ApiRepositoryImpl());
}