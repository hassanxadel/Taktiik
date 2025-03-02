import 'package:provider/provider.dart';
import 'package:taktiik/presentation/providers/match_provider.dart';
import 'package:taktiik/data/repositories/match_repository.dart';
import 'package:taktiik/data/datasources/remote/match_remote_datasource.dart';
import 'package:dio/dio.dart';

final appProviders = [
  ChangeNotifierProvider(
    create: (_) => MatchProvider(
      MatchRepositoryImpl(
        remoteDataSource: MatchRemoteDataSourceImpl(
          dio: Dio(),
        ),
      ),
    ),
  ),
  // Add more providers as needed
];
