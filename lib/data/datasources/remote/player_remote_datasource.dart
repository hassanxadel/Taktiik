import 'package:dio/dio.dart';
import '../../../core/constants/app_constants.dart';
import '../../models/player.dart';

abstract class PlayerRemoteDataSource {
  Future<Player> fetchPlayerDetails(int playerId);
  Future<List<Player>> fetchPlayersByTeam(int teamId);
}

class PlayerRemoteDataSourceImpl implements PlayerRemoteDataSource {
  final Dio dio;

  PlayerRemoteDataSourceImpl({required this.dio});

  @override
  Future<Player> fetchPlayerDetails(int playerId) async {
    final response = await dio.get(
      '/players/$playerId',
      options: Options(headers: AppConstants.apiHeaders),
    );
    return Player.fromJson(response.data);
  }

  @override
  Future<List<Player>> fetchPlayersByTeam(int teamId) async {
    final response = await dio.get(
      '/teams/$teamId/players',
      options: Options(headers: AppConstants.apiHeaders),
    );
    return (response.data['squad'] as List)
        .map((json) => Player.fromJson(json))
        .toList();
  }
}