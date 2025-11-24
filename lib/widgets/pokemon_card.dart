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
          child: Row(
            children: [

              // Hero Animation
              Hero(
                tag: "pokemon-${pokemon.id}",
                child: Image.network(
                  pokemon.imageUrl,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(width: 16),

              // se adapta al espacio
              Expanded(
                child: Text(
                  pokemon.name.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.pressStart2p(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
