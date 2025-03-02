import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/errors/exceptions.dart';

abstract class FavoritesLocalDataSource {
  Future<List<int>> getFavoriteTeamIds();
  Future<void> saveFavoriteTeam(int teamId);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final SharedPreferences prefs;

  FavoritesLocalDataSourceImpl({required this.prefs});

  @override
  Future<List<int>> getFavoriteTeamIds() async {
    try {
      return prefs.getStringList('favoriteTeams')?.map(int.parse).toList() ?? [];
    } catch (e) {
      throw const CacheException('Failed to load favorites');
    }
  }

  @override
  Future<void> saveFavoriteTeam(int teamId) async {
    try {
      final current = await getFavoriteTeamIds();
      if (!current.contains(teamId)) {
        current.add(teamId);
        await prefs.setStringList(
          'favoriteTeams',
          current.map((id) => id.toString()).toList(),
        );
      }
    } catch (e) {
      throw const CacheException('Failed to save favorite');
    }
  }
}