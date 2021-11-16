import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex_2021/common/repositories/pokemon_repository.dart';
import 'package:flutter_pokedex_2021/features/home/container/home_container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex 2K21',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomeContainer(
        repository: PokemonRepository(
          dio: Dio(),
        ),
      ),
    );
  }
}
