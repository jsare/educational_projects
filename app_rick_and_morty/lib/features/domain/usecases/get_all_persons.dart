import 'package:app_rick_and_morty/core/error/failure.dart';
import 'package:app_rick_and_morty/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/person_repository.dart';
import '../entities/person_entity.dart';

class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParams> {
  // Создаём переменную, в которую будем передавать нам данные из Repository
  final PersonRepository personRepository;

  GetAllPersons(this.personRepository);

  @override
  Future<Either<Failure, List<PersonEntity>>> call(
      PagePersonParams params) async {
    return await personRepository.getAllUsers(params.page);
  }
}

class PagePersonParams extends Equatable {
  final int page;

  const PagePersonParams({required this.page});

  @override
  List<Object?> get props => [page];
}
