import 'package:flutter/material.dart';
import '../models/pokemon_basic.dart';

class PokemonCard extends StatelessWidget {
  final PokemonBasic pokemon;
  final VoidCallback onTap;

  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Image.network(pokemon.imageUrl),
        title: Text(
          pokemon.name.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("#${pokemon.id}"),
        onTap: onTap,
      ),
    );
  }
}
