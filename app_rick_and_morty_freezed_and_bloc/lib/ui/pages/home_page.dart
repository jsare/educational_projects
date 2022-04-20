import 'package:app_rick_and_morty_freezed_and_bloc/bloc/character_bloc.dart';
import 'package:app_rick_and_morty_freezed_and_bloc/data/repository/character_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_page.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  String title;
  final repositoty = CharacterRepo();
  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: BlocProvider(
        create: (context) => CharacterBloc(characterRepo: repositoty),
        child: Container(
          decoration: const BoxDecoration(color: Colors.black87),
          child: const SearchPage(),
        ),
      ),
    );
  }
}
