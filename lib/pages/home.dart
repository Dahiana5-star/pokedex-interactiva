// ignore: uri_does_not_exist
import 'package:flutter/material.dart';
import '../services/pokemon_service.dart';
import '../models/pokemon_basic.dart';
import '../widgets/pokemon_card.dart';
import '../pages/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PokemonService service = PokemonService();
  List<PokemonBasic> pokemonList = [];
  List<PokemonBasic> filteredList = [];

  int offset = 0;
  bool isLoading = false;
  bool isSearching = false;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMorePokemon();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchMorePokemon();
      }
    });
  }

  Future<void> fetchMorePokemon() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    final data = await service.fetchPokemonList(offset);
    final newList = data['results']
        .map<PokemonBasic>((json) => PokemonBasic.fromJson(json))
        .toList();

    setState(() {
      pokemonList.addAll(newList);
      filteredList = pokemonList;
      offset += 20;
      isLoading = false;
    });
  }

  void searchPokemon(String value) {
    setState(() {
      isSearching = value.isNotEmpty;
      filteredList = pokemonList
          .where((p) => p.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pokédex"), centerTitle: true),
      body: Column(
        children: [
          // 🔎 Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              onChanged: searchPokemon,
              decoration: InputDecoration(
                hintText: "Buscar Pokémon...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          Expanded(
            child: filteredList.isEmpty
                ? const Center(
                    child: Text(
                      "No se encontraron resultados",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: filteredList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == filteredList.length) {
                        return isLoading
                            ? const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : const SizedBox();
                      }

                      final pokemon = filteredList[index];

                      return PokemonCard(
                        pokemon: pokemon,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(id: pokemon.id),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
