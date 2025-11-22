import 'package:flutter/material.dart';
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
  PokemonDetail?
  detail; // Assuming PokemonDetail is a model class for detailed info about a Pokemon

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
      appBar: AppBar(title: Text(detail!.name.toUpperCase())),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(detail!.imageUrl, height: 200),
            const SizedBox(height: 20),
            Text(
              "#${detail!.id} - ${detail!.name.toUpperCase()}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Tipo(s): ${detail!.types.join(', ')}"),
            Text("Altura: ${detail!.height}"),
            Text("Peso: ${detail!.weight}"),
          ],
        ),
      ),
    );
  }
}
