import 'package:dio/dio.dart';
import '../../../core/constants/app_constants.dart';
import '../../models/team.dart';

abstract class TeamRemoteDataSource {
  Future<Team> fetchTeamDetails(int teamId);
  Future<List<Team>> fetchTeamsByCompetition(int competitionId);
}

class TeamRemoteDataSourceImpl implements TeamRemoteDataSource {
  final Dio dio;

  TeamRemoteDataSourceImpl({required this.dio});

  @override
  Future<Team> fetchTeamDetails(int teamId) async {
    final response = await dio.get(
      '/teams/$teamId',
      options: Options(headers: AppConstants.apiHeaders),
    );
    return Team.fromJson(response.data);
  }

  @override
  Future<List<Team>> fetchTeamsByCompetition(int competitionId) async {
    final response = await dio.get(
      '/competitions/$competitionId/teams',
      options: Options(headers: AppConstants.apiHeaders),
    );
    return (response.data['teams'] as List)
        .map((json) => Team.fromJson(json))
        .toList();
  }
}
