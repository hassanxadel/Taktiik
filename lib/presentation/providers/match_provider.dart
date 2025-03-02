import 'package:flutter/foundation.dart';
import '../../../core/errors/exceptions.dart';
import '../../../data/repositories/match_repository.dart';
import '../../../data/models/match.dart' as project_match;

class MatchProvider with ChangeNotifier {
  final MatchRepository _repository;
  List<project_match.Match> _liveMatches = [];
  List<project_match.Match> _upcomingMatches = [];
  bool _isLoading = false;
  String? _error;
  project_match.Match? _matchDetails;

  MatchProvider(this._repository);

  // Getters
  List<project_match.Match> get liveMatches => _liveMatches;
  List<project_match.Match> get upcomingMatches => _upcomingMatches;
  bool get isLoading => _isLoading;
  String? get error => _error;
  project_match.Match? get matchDetails => _matchDetails;

  Future<void> loadLiveMatches() async {
    try {
      _startLoading();
      _liveMatches = await _repository.getLiveMatches();
      _clearError();
    } on ServerException catch (e) {
      _setError(e.message);
    } finally {
      _stopLoading();
    }
  }

  Future<void> loadUpcomingMatches() async {
    try {
      _startLoading();
      _upcomingMatches = await _repository.getUpcomingMatches();
      _clearError();
    } on ServerException catch (e) {
      _setError(e.message);
    } finally {
      _stopLoading();
    }
  }

  Future<void> loadMatchDetails(String matchId) async {
    try {
      _startLoading();
      _matchDetails = await _repository.getMatchDetails(matchId);
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