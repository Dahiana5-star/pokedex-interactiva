import 'package:flutter/material.dart';
import 'package:mi_pokedex_interactiva/services/favorite_service.dart';
import '../services/pokemon_service.dart';
import '../models/pokemon_detail.dart';

class DetailPage extends StatefulWidget {
  final int id;

  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final PokemonService service = PokemonService();
  PokemonDetail? detail;

  @override
  void initState() {
    super.initState();
    loadDetail();
  }

  Future<void> loadDetail() async {
    final data = await service.fetchPokemonDetail(widget.id);
    setState(() {
      detail = PokemonDetail.fromJson(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (detail == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(detail!.name.toUpperCase()),
        centerTitle: true,
        actions: [
          FutureBuilder<bool>(
            future: FavoriteService.isFavorite(detail!.id),
            builder: (context, snapshot) {
              final isFav = snapshot.data ?? false;

              return IconButton(
                icon: Icon(isFav ? Icons.star : Icons.star_border),
                onPressed: () async {
                  if (isFav) {
                    await FavoriteService.removeFavorite(detail!.id);
                  } else {
                    await FavoriteService.addFavorite(detail!.id);
                  }
                  setState(() {}); // refrescar icono
                },
              );
            },
          ),
        ],
      ),

      body: Center(
        // CENTRA TODO
        child: SingleChildScrollView(
          // evita overflow en pantallas chicas
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // centra vertical
              crossAxisAlignment:
                  CrossAxisAlignment.center, // centra horizontal
              children: [
                Hero(
                  tag: "pokemon-${detail!.id}",
                  child: Image.network(detail!.imageUrl, height: 200),
                ),
                const SizedBox(height: 20),

                Text(
                  "#${detail!.id} - ${detail!.name.toUpperCase()}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                Text(
                  "Tipo(s): ${detail!.types.join(', ')}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),

                Text("Altura: ${detail!.height}"),
                Text("Peso: ${detail!.weight}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
