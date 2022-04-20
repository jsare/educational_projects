// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:app_rick_and_morty/features/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:app_rick_and_morty/features/presentation/bloc/search_bloc/search_event.dart';
import 'package:app_rick_and_morty/features/presentation/bloc/search_bloc/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/person_entity.dart';
import 'search_result_widget.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for Characters');

  final _suggestions = [
    'Rick',
    'Morty',
    'Summer',
    'Beth',
    'Jerry',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    log('Inside custom search delegate and search query is $query');
    BlocProvider.of<PersonSearchBloc>(context, listen: false)
        .add(SearchPersons(query));
    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
      builder: (context, state) {
        if (state is PersonSearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PersonSearchLoaded) {
          final person = state.persons;
          if (person.isEmpty) {
            return _showErrorText('No Characters with that name found');
          }
          return ListView.builder(
            itemCount: person.isNotEmpty ? person.length : 0,
            itemBuilder: (context, index) {
              PersonEntity result = person[index];
              return SearchResult(personResult: result);
            },
          );
        } else if (state is PersonSearchError) {
          return _showErrorText(state.message);
        } else {
          return const Center(
            child: Icon(Icons.now_wallpaper),
          );
        }
      },
    );
  }

  Widget _showErrorText(String errorMessage) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<PersonEntity> persons = [];
    bool isLoading = false;
    if (query.isNotEmpty) {
      return Container();
    }

    return ListView.separated(
      padding: const EdgeInsets.all(10.0),
      itemBuilder: (context, index) {
        return Text(
          _suggestions[index],
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: _suggestions.length,
    );
  }
}
