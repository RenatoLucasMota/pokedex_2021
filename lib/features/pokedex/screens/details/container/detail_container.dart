import 'package:flutter/material.dart';
import 'package:flutter_pokedex_2021/common/error/failure.dart';
import 'package:flutter_pokedex_2021/common/models/pokemon.dart';
import 'package:flutter_pokedex_2021/common/repositories/pokemon_repository.dart';
import 'package:flutter_pokedex_2021/common/widgets/po_error.dart';
import 'package:flutter_pokedex_2021/common/widgets/po_loading.dart';
import 'package:flutter_pokedex_2021/features/pokedex/screens/details/pages/detail_page.dart';

class DetailArguments {
  DetailArguments({this.index = 0, required this.pokemon});
  final Pokemon pokemon;
  final int? index;
}

class DetailContainer extends StatefulWidget {
  const DetailContainer(
      {Key? key,
      required this.repository,
      required this.arguments,
      required this.onBack})
      : super(key: key);
  final IPokemonRepository repository;
  final DetailArguments arguments;
  final VoidCallback onBack;

  @override
  _DetailContainerState createState() => _DetailContainerState();
}

class _DetailContainerState extends State<DetailContainer> {
  late PageController _controller;
  late Future<List<Pokemon>> _future;
  Pokemon? _pokemon;
  @override
  void initState() {
    _controller = PageController(
        viewportFraction: 0.5, initialPage: widget.arguments.index!);
    _future = widget.repository.getAllPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pokemon>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return PoLoading();
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          if (_pokemon == null) {
            _pokemon = widget.arguments.pokemon;
          }
          return DetailPage(
            pokemon: _pokemon!,
            list: snapshot.data!,
            onBack: widget.onBack,
            controller: _controller,
            onChangePokemon: (Pokemon value) {
              setState(() {
                _pokemon = value;
              });
            },
          );
        }

        if (snapshot.hasError) {
          return PoError(
            error: (snapshot.error as Failure).message!,
          );
        }

        return Container();
      },
    );
  }
}
