import 'package:dartz/dartz.dart';
import 'package:app_rick_and_morty/core/error/failure.dart';
import 'package:app_rick_and_morty/features/domain/entities/person_entity.dart';

abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntity>>> getAllUsers(int page);
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);
}
