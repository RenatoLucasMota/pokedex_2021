import 'package:flutter/material.dart';
import 'package:flutter_pokedex_2021/common/error/failure.dart';
import 'package:flutter_pokedex_2021/common/models/pokemon.dart';
import 'package:flutter_pokedex_2021/common/repositories/pokemon_repository.dart';
import 'package:flutter_pokedex_2021/features/home/pages/home_error.dart';
import 'package:flutter_pokedex_2021/features/home/pages/home_loading.dart';
import 'package:flutter_pokedex_2021/features/home/pages/home_page.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({Key? key, required this.repository}) : super(key: key);
  final IPokemonRepository repository;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pokemon>>(
      future: repository.getAllPokemons(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return HomeLoading();
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return HomePage(list: snapshot.data!);
        }

        if (snapshot.hasError) {
          return HomeError(
            error: (snapshot.error as Failure).message!,
          );
        }

        return Container();
      },
    );
  }
}
