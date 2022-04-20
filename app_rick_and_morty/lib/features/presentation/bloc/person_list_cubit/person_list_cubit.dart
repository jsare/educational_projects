import 'dart:developer';

import 'package:app_rick_and_morty/core/error/failure.dart';
import 'package:app_rick_and_morty/features/domain/entities/person_entity.dart';
import 'package:app_rick_and_morty/features/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_all_persons.dart';

const serverFailureMassage = 'Server Failure';
const cacheFailureMassage = 'Cache Failure';

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;
  PersonListCubit({required this.getAllPersons}) : super(PersonEmpty());

  int page = 1;

  void loadPerson() async {
    if (state is PersonLoading) return;

    final currentState = state;

    var oldPerson = <PersonEntity>[];
    if (currentState is PersonLoaded) {
      oldPerson = currentState.personsList;
    }

    emit(PersonLoading(oldPerson, isFirstFetch: page == 1));

    final failureOrPerson = await getAllPersons(PagePersonParams(page: page));

    failureOrPerson.fold(
        (error) => emit(PersonError(message: _mapFailureToMessage(error))),
        (character) {
      page++;
      final persons = (state as PersonLoading).oldPersonsList;
      persons.addAll(character);
      log('List length: ${persons.length.toString()}');
      emit(PersonLoaded(persons));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMassage;
      case CacheFailure:
        return cacheFailureMassage;
      default:
        return 'Unexpected message';
    }
  }
}
