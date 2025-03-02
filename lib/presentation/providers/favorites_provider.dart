import 'package:flutter/foundation.dart';
import '../../../core/errors/exceptions.dart';
import '../../../data/models/team.dart';
import '../../../data/repositories/favorites_repository.dart';
import '../../../data/repositories/team_repository.dart';

class FavoritesProvider with ChangeNotifier {
  final FavoritesRepository _repository;
  final TeamRepository _teamRepository;
  List<Team> _favoriteTeams = [];
  bool _isLoading = false;
  String? _error;

  FavoritesProvider(this._repository, this._teamRepository);

  List<Team> get favoriteTeams => _favoriteTeams;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadFavorites() async {
    try {
      _startLoading();
      final teamIds = await _repository.getFavoriteTeamIds();
      _favoriteTeams = await _teamRepository.getTeamsByIds(teamIds);
      _clearError();
    } on CacheException catch (e) {
      _setError(e.message);
    } finally {
      _stopLoading();
    }
  }

  Future<void> toggleFavorite(Team team) async {
    try {
      if (_favoriteTeams.any((t) => t.id == team.id)) {
        await _repository.removeFavoriteTeam(team.id);
        _favoriteTeams.removeWhere((t) => t.id == team.id);
      } else {
        await _repository.addFavoriteTeam(team.id);
        _favoriteTeams.add(team);
      }
      notifyListeners();
    } on FavoriteLimitExceededException catch (e) {
      _setError(e.message);
    } on CacheException catch (e) {
      _setError(e.message);
    }
  }

  // Helper methods
  void _startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void _setError(String message) {
    _error = message;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
}