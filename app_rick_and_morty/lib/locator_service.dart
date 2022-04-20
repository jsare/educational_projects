import 'package:app_rick_and_morty/core/platform/network_info.dart';
import 'package:app_rick_and_morty/features/data/datasources/person_local_data_source.dart';
import 'package:app_rick_and_morty/features/data/datasources/person_remote_data_sorce.dart';
import 'package:app_rick_and_morty/features/domain/repositories/person_repository.dart';
import 'package:app_rick_and_morty/features/domain/repositories/person_repository_impl.dart';
import 'package:app_rick_and_morty/features/domain/usecases/get_all_persons.dart';
import 'package:app_rick_and_morty/features/domain/usecases/search_person.dart';
import 'package:app_rick_and_morty/features/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:app_rick_and_morty/features/presentation/bloc/search_bloc/search_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

/* 
Вся регистрация классов в Сервис Локаторе будет проходить в методе init.
Регистрировать классы будем сверху вниз по потоку вызовов.
В нашем случае это значит, что начнём с PersonListCubit и Search блока, и закончим
внешними зависимостями, такими как shared_preferences и http.client.
*/

Future<void> init() async {
  // BLoc / Cubit
  sl.registerFactory(
    () => PersonListCubit(getAllPersons: sl()),
  );
  sl.registerFactory(
    () => PersonSearchBloc(searchPerson: sl()),
  );

  // UseCases
  sl.registerLazySingleton(
    () => GetAllPersons(sl()),
  );
  sl.registerLazySingleton(
    () => SearchPerson(sl()),
  );

  // Repository
  sl.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<PersonRemoteDataSource>(
    () => PersonRemoteDataSourceImpl(
      client: http.Client(),
    ),
  );

  sl.registerLazySingleton<PersonLocalDataSource>(
    () => PersonLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
