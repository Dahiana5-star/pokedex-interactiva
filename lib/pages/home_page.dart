import 'package:flutter/material.dart';
import '../services/pokemon_service.dart';
import '../models/pokemon_basic.dart';
import '../widgets/pokemon_card.dart';
import 'detail_page.dart';

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

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPokemon(); // carga los 150
  }

  Future<void> fetchPokemon() async {
    setState(() => isLoading = true);

    final data = await service.fetchPokemonList(0); // siempre 0

    final list = data['results']
        .map<PokemonBasic>((json) => PokemonBasic.fromJson(json))
        .toList();

    setState(() {
      pokemonList = list;
      filteredList = list;
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
          // Barra de búsqueda
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
           child: isLoading
      ? const Center(child: CircularProgressIndicator())
      : filteredList.isEmpty
          ? const Center(child: Text("No se encontraron resultados"))
          : ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
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
