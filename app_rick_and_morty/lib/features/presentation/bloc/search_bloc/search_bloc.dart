import 'dart:async';

import 'package:app_rick_and_morty/features/presentation/bloc/search_bloc/search_event.dart';
import 'package:app_rick_and_morty/features/presentation/bloc/search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../domain/usecases/search_person.dart';

const serverFailureMassage = 'Server Failure';
const cacheFailureMassage = 'Cache Failure';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonSearchEmpty()) {
    on<SearchPersons>(_onEvent);
  }

  FutureOr<void> _onEvent(
      SearchPersons event, Emitter<PersonSearchState> emit) async {
    emit(PersonSearchLoading());
    final failureOrPerson =
        await searchPerson(SearchPersonParams(query: event.personQuery));
    emit(failureOrPerson.fold(
        (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
        (person) => PersonSearchLoaded(persons: person)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMassage;
      case CacheFailure:
        return cacheFailureMassage;
      default:
        return 'Unexpected Error';
    }
  }
}
