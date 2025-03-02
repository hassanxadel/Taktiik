import 'package:dio/dio.dart';
import '../../../core/errors/exceptions.dart';
import '../../../data/datasources/remote/player_remote_datasource.dart';
import '../../../data/models/player.dart';

abstract class PlayerRepository {
  Future<Player> getPlayerDetails(int playerId);
  Future<List<Player>> getPlayersByTeam(int teamId);
}

class PlayerRepositoryImpl implements PlayerRepository {
  final PlayerRemoteDataSource remoteDataSource;

  PlayerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Player> getPlayerDetails(int playerId) async {
    try {
      return await remoteDataSource.fetchPlayerDetails(playerId);
    } on DioError catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch player details');
    }
  }

  @override
  Future<List<Player>> getPlayersByTeam(int teamId) async {
    try {
      return await remoteDataSource.fetchPlayersByTeam(teamId);
    } on DioError catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch team players');
    }
  }
}