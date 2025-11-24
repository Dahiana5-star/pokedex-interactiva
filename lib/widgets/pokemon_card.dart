import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/pokemon_basic.dart';

class PokemonCard extends StatelessWidget {
  final PokemonBasic pokemon;
  final VoidCallback onTap;

  const PokemonCard({super.key, required this.pokemon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color(0xFFA29BFE), // lila claro
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: "pokemon-${pokemon.id}",
                child: Image.network(
                  pokemon.imageUrl,
                  height: 90,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8),

              // Número del Pokémon
              Text(
                "#${pokemon.id.toString().padLeft(3, '0')}",
                style: GoogleFonts.pressStart2p(
                  fontSize: 10,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 4),

              // Nombre
              Text(
                pokemon.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.pressStart2p(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
