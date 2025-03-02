import '../../../core/constants/app_constants.dart';
import '../../../core/errors/exceptions.dart';
import '../../../data/datasources/local/favorites_local_datasource.dart';

abstract class FavoritesRepository {
  Future<List<int>> getFavoriteTeamIds();
  Future<void> addFavoriteTeam(int teamId);
  Future<void> removeFavoriteTeam(int teamId);
}

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addFavoriteTeam(int teamId) async {
    final currentFavorites = await localDataSource.getFavoriteTeamIds();
    if (currentFavorites.length >= AppConstants.maxFavoriteTeams) {
      throw FavoriteLimitExceededException();
    }
    await localDataSource.saveFavoriteTeam(teamId);
  }

  @override
  Future<List<int>> getFavoriteTeamIds() async {
    try {
      return await localDataSource.getFavoriteTeamIds();
    } on CacheException {
      throw const CacheException('Failed to load favorites');
    }
  }

  @override
  Future<void> removeFavoriteTeam(int teamId) async {
    try {
      final currentFavorites = await localDataSource.getFavoriteTeamIds();
      if (currentFavorites.contains(teamId)) {
        currentFavorites.remove(teamId);
        for (var id in currentFavorites) {
          await localDataSource.saveFavoriteTeam(id);
        }
      }
    } catch (e) {
      throw const CacheException('Failed to remove favorite');
    }
  }
}