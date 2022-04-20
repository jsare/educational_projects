import 'package:app_rick_and_morty/features/domain/entities/person_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object?> get props => [];
}

class PersonEmpty extends PersonState {
  @override
  List<Object?> get props => [];
}

class PersonLoading extends PersonState {
  // Переменная для подгрузки персонажей
  final List<PersonEntity> oldPersonsList;
  // Переменная, которая проверяет, подгружен ли 1-й список, если будет 2-я
  // страница, то будем релизовывать новую подгрузку к старым, через [oldPersonList]
  final bool isFirstFetch;

  const PersonLoading(this.oldPersonsList, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldPersonsList];
}

class PersonLoaded extends PersonState {
  final List<PersonEntity> personsList;

  const PersonLoaded(this.personsList);

  @override
  List<Object?> get props => [personsList];
}

class PersonError extends PersonState {
  final String message;

  const PersonError({required this.message});

  @override
  List<Object?> get props => [message];
}
