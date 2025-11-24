import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String key = "favorite_ids";

  // Obtener lista de favoritos
  static Future<List<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];
    return list.map(int.parse).toList();
  }

  // Agregar favorito
  static Future<void> addFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];
    if (!list.contains(id.toString())) {
      list.add(id.toString());
      await prefs.setStringList(key, list);
    }
  }

  // Quitar favorito
  static Future<void> removeFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];
    list.remove(id.toString());
    await prefs.setStringList(key, list);
  }

  // Verificar si es favorito
  static Future<bool> isFavorite(int id) async {
    final list = await getFavorites();
    return list.contains(id);
  }
}
