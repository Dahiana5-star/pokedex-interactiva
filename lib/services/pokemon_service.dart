import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonService {
  final String baseUrl = "https://pokeapi.co/api/v2/pokemon";

  Future<Map<String, dynamic>> fetchPokemonList(int offset) async {
    final url = Uri.parse("$baseUrl?limit=20&offset=$offset");

    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception("Error al cargar Pokémon");
    }

    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> fetchPokemonDetail(int id) async {
    final url = Uri.parse("$baseUrl/$id");
    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception("Error al cargar detalles");
    }

    return jsonDecode(res.body);
  }
}
