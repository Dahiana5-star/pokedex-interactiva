import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
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
  final AudioPlayer player = AudioPlayer();

  PokemonDetail? detail;

  @override
  void initState() {
    super.initState();
    loadDetail();
  }

  // Liberar recursos del reproductor
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> loadDetail() async {
    final data = await service.fetchPokemonDetail(widget.id);
    setState(() {
      detail = PokemonDetail.fromJson(data);
    });
  }

  String normalizeCryName(String name) {
    return name
        .toLowerCase()
        .replaceAll(" ", "")
        .replaceAll("-", "")
        .replaceAll(".", "")
        .replaceAll("'", "")
        .replaceAll("♀", "f")
        .replaceAll("♂", "m");
  }

  // Reproducir sonido MP3 local
  Future<void> playLocalCry() async {
    if (detail == null) return;

    final cryName = normalizeCryName(detail!.name);
    // La ruta relativa que debe ser declarada en pubspec.yaml: sounds/nombre.mp3
    final assetPath = "sounds/$cryName.mp3"; 
    
    print("Intentando reproducir sonido local: $assetPath");

    try {
      await player.stop();
      // AssetSource espera la ruta relativa a la carpeta 'assets' declarada
      await player.play(AssetSource(assetPath)); 
      print("Reproducción iniciada exitosamente.");
    } catch (e) {
      // Un mensaje de error más útil
      print("ERROR cargando sonido local desde '$assetPath': $e");
      print("Asegúrate de que la ruta '$assetPath' esté correcta y declarada en pubspec.yaml.");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (detail == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }

    // El resto del widget build es el mismo...
    return Scaffold(
      appBar: AppBar(
        title: Text(detail!.name.toUpperCase()),
        centerTitle: true,
        actions: [
          /// FAVORITOS
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
                  setState(() {});
                },
              );
            },
          ),

          /// BOTÓN DE SONIDO LOCAL
          IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: playLocalCry,
          )
        ],
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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