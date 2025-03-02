import 'package:flutter/foundation.dart';
import '../../../core/errors/exceptions.dart';
import '../../../data/models/team.dart';
import '../../../data/repositories/team_repository.dart';
import '../../../data/models/player.dart';


class TeamProvider with ChangeNotifier {
  final TeamRepository _repository;
  Team? _selectedTeam;
  List<Player> _squad = [];
  bool _isLoading = false;
  String? _error;

  TeamProvider(this._repository);

  Team? get selectedTeam => _selectedTeam;
  List<Player> get squad => _squad;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadTeamDetails(int teamId) async {
    try {
      _startLoading();
      _selectedTeam = await _repository.getTeamDetails(teamId);
      _squad = await _repository.getTeamSquad(teamId);
      _clearError();
    } on ServerException catch (e) {
      _setError(e.message);
    } finally {
      _stopLoading();
    }
  }

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