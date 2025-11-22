class PokemonDetail {
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final List<String> types;
  final List<String> abilities;
  final Map<String, int> stats; // ej: {"hp": 45, "attack": 49}

  PokemonDetail({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
    required this.stats,
  });

  static PokemonDetail fromJson(Map<String, dynamic> json) {
    final id = json['id'];

    // Imagen oficial
    final imageUrl =
        json['sprites']['other']['official-artwork']['front_default'];

    // Lista de tipos
    final types = (json['types'] as List)
        .map((t) => t['type']['name'] as String)
        .toList();

    // Lista de habilidades
    final abilities = (json['abilities'] as List)
        .map((a) => a['ability']['name'] as String)
        .toList();

    // Stats (hp, attack, defense, etc.)
    final stats = <String, int>{};
    for (var s in json['stats']) {
      stats[s['stat']['name']] = s['base_stat'];
    }

    return PokemonDetail(
      id: id,
      name: json['name'],
      imageUrl: imageUrl,
      height: json['height'],
      weight: json['weight'],
      types: types,
      abilities: abilities,
      stats: stats,
    );
  }
}
