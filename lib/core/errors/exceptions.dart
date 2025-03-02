import 'package:meta/meta.dart';
import '../constants/app_constants.dart';

@immutable
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

// API Exceptions
class ServerException extends AppException {
  const ServerException(super.message);
}

class CacheException extends AppException {
  const CacheException(super.message);
}

class NetworkException extends AppException {
  const NetworkException(super.message);
}

// Business Logic Exceptions
class FavoriteLimitExceededException extends AppException {
  const FavoriteLimitExceededException()
      : super('Maximum \\${AppConstants.maxFavoriteTeams} favorite teams allowed');
}

class NotificationPermissionDeniedException extends AppException {
  const NotificationPermissionDeniedException()
      : super('Please enable notifications in settings');
}