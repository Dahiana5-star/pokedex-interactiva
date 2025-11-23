class PokemonBasic {
  final int id;
  final String name;
  final String imageUrl;

  PokemonBasic({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  static PokemonBasic fromJson(Map<String, dynamic> json) {
    final url = json['url'];
    final id = int.parse(url.split('/')[url.split('/').length - 2]);

    return PokemonBasic(
      id: id,
      name: json['name'],
      imageUrl:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png",
    );
  }
}
