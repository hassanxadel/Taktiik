class AppConstants {
  // API Configuration
  static const String apiBaseUrl = 'https://api.football-data.org/v4';
  static const String apiKey = '7110ffdf9ff84c17bfb4457442362c78';
  static const Map<String, String> apiHeaders = {
    'X-Auth-Token': apiKey,
    'Content-Type': 'application/json'
  };

  // App Configuration
  static const String appName = 'Football Live';
  static const Duration matchRefreshInterval = Duration(seconds: 30);
  static const int maxFavoriteTeams = 5;

  // Navigation Routes
  static const String homeRoute = '/';
  static const String liveMatchesRoute = '/live';
  static const String upcomingMatchesRoute = '/upcoming';
  static const String favoritesRoute = '/favorites';
  static const String matchDetailsRoute = '/match-details';
  // Error Messages
  static const String connectionError = 'No internet connection';
  static const String serverError = 'Server error, please try again later';
}