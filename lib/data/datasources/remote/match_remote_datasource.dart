import 'package:dio/dio.dart';
import '../../../core/constants/app_constants.dart';
import '../../models/match.dart';

abstract class MatchRemoteDataSource {
  Future<List<Match>> fetchLiveMatches();
  Future<Match> fetchMatchDetails(String matchId);
  Future<List<Match>> fetchUpcomingMatches();
}

class MatchRemoteDataSourceImpl implements MatchRemoteDataSource {
  final Dio dio;

  MatchRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<Match>> fetchLiveMatches() async {
    final response = await dio.get(
      '/matches',
      queryParameters: {'status': 'LIVE'},
      options: Options(headers: AppConstants.apiHeaders),
    );

    return (response.data['matches'] as List)
        .map((json) => Match.fromJson(json))
        .toList();
  }

  @override
  Future<Match> fetchMatchDetails(String matchId) async {
    final response = await dio.get(
      '/matches/$matchId',
      options: Options(headers: AppConstants.apiHeaders),
    );

    return Match.fromJson(response.data);
  }

  @override
  Future<List<Match>> fetchUpcomingMatches() async {
    final response = await dio.get(
      '/matches',
      queryParameters: {'status': 'UPCOMING'},
      options: Options(headers: AppConstants.apiHeaders),
    );

    return (response.data['matches'] as List)
        .map((json) => Match.fromJson(json))
        .toList();
  }
}