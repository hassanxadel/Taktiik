import 'package:dio/dio.dart';
import '../../../core/errors/exceptions.dart';
import '../../../data/datasources/remote/team_remote_datasource.dart';
import '../../../data/models/team.dart';
import '../../../data/models/player.dart';

abstract class TeamRepository {
  Future<Team> getTeamDetails(int teamId);
  Future<List<Team>> getTeamsByCompetition(int competitionId);
  Future<List<Player>> getTeamSquad(int teamId);
  Future<List<Team>> getTeamsByIds(List<int> teamIds);
}

class TeamRepositoryImpl implements TeamRepository {
  final TeamRemoteDataSource remoteDataSource;

  TeamRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Team> getTeamDetails(int teamId) async {
    try {
      return await remoteDataSource.fetchTeamDetails(teamId);
    } on DioError catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch team details');
    }
  }

  @override
  Future<List<Team>> getTeamsByCompetition(int competitionId) async {
    try {
      return await remoteDataSource.fetchTeamsByCompetition(competitionId);
    } on DioError catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch competition teams');
    }
  }

  @override
  Future<List<Player>> getTeamSquad(int teamId) async {
    try {
      final team = await remoteDataSource.fetchTeamDetails(teamId);
      return team.squad;
    } on DioError catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch team squad');
    }
  }

  @override
  Future<List<Team>> getTeamsByIds(List<int> teamIds) {
    // Implementation needed
    throw UnimplementedError();
  }
}