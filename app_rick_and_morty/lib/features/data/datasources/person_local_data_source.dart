// ignore_for_file: void_checks

import 'dart:convert';
import 'dart:developer';

import 'package:app_rick_and_morty/core/error/exception.dart';
import 'package:app_rick_and_morty/features/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  /// Gets the cached [List<PersonModel>] which was gotten the last time
  /// the user had an internet connection
  ///
  /// Throws [CacheExceprtion] if no cached data in present.
  Future<List<PersonModel>> getLastPersonsFromCashe();
  Future<void> personsToCash(List<PersonModel> persons);
}

const cashedPersonsList = 'CashedPersonsList';

class PersonLocalDataSourceImpl extends PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<PersonModel>> getLastPersonsFromCashe() {
    final jsonPersonsList = sharedPreferences.getStringList(cashedPersonsList);
    if (jsonPersonsList!.isNotEmpty) {
      log('Get Persons from Cache: ${jsonPersonsList.length}');
      return Future.value(jsonPersonsList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> personsToCash(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((person) => json.encode(person.toJson())).toList();

    sharedPreferences.setStringList(cashedPersonsList, jsonPersonsList);
    log('Persons to write Cashe: $jsonPersonsList');
    return Future.value(jsonPersonsList);
  }
}
