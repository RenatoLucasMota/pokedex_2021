import 'package:flutter/material.dart';
import 'package:flutter_pokedex_2021/common/models/pokemon.dart';

import 'widgets/detail_app_bar_widget.dart';
import 'widgets/detail_list_widget.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
    required this.pokemon,
    required this.list,
    required this.onBack,
    required this.controller,
    required this.onChangePokemon,
  }) : super(key: key);
  final Pokemon pokemon;
  final List<Pokemon> list;
  final VoidCallback onBack;
  final PageController controller;
  final ValueChanged<Pokemon> onChangePokemon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DetailAppBarWidget(
            pokemon: pokemon,
            onBack: onBack,
          ),
          DetailListWidget(
            pokemon: pokemon,
            list: list,
            controller: controller,
            onChangePokemon: onChangePokemon,
          ),
        ],
      ),
    );
  }
}
