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
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color(0xFF4A148C), // Morado oscuro
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              // Imagen del Pokémon
              Image.network(
                pokemon.imageUrl,
                width: 80,
                height: 80,
              ),

              const SizedBox(width: 20),

              // Nombre del Pokémon
              Expanded(
                child: Text(
                  pokemon.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),

              // ID
              Text(
                "#${pokemon.id}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
