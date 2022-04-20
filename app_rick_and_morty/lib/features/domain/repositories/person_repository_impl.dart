import 'package:app_rick_and_morty/core/error/exception.dart';
import 'package:app_rick_and_morty/core/platform/network_info.dart';
import 'package:app_rick_and_morty/features/data/datasources/person_local_data_source.dart';
import 'package:app_rick_and_morty/features/data/datasources/person_remote_data_sorce.dart';
import 'package:app_rick_and_morty/features/domain/entities/person_entity.dart';
import 'package:app_rick_and_morty/core/error/failure.dart';
import 'package:app_rick_and_morty/features/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/person_model.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllUsers(int page) async {
    return await _getPersons(() {
      return remoteDataSource.getAllPersons(page);
    });
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPersons(() {
      return remoteDataSource.searchPerson(query);
    });
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        // Реализуем получение данных из [RemoteDataSource]
        final remotePerson = await getPersons();
        // Если персонажи успешно получены из Api, то кэшируем их на ус-во.
        localDataSource.personsToCash(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationPerson = await localDataSource.getLastPersonsFromCashe();
        return Right(locationPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
