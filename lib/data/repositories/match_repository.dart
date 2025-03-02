import '../../../core/errors/exceptions.dart';
import '../../../data/datasources/remote/match_remote_datasource.dart';
import 'package:dio/dio.dart';
import '../../../data/models/match.dart';


abstract class MatchRepository {
  Future<List<Match>> getLiveMatches();
  Future<List<Match>> getUpcomingMatches();
  Future<Match> getMatchDetails(String matchId);
}

class MatchRepositoryImpl implements MatchRepository {
  final MatchRemoteDataSource remoteDataSource;

  MatchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Match>> getLiveMatches() async {
    try {
      return await remoteDataSource.fetchLiveMatches();
    } on DioError catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch live matches');
    }
  }

  @override
  Future<List<Match>> getUpcomingMatches() async {
    try {
      return await remoteDataSource.fetchUpcomingMatches();
    } on DioError catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch upcoming matches');
    }
  }

  @override
  Future<Match> getMatchDetails(String matchId) async {
    try {
      return await remoteDataSource.fetchMatchDetails(matchId);
    } on DioError catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch match details');
    }
  }
}