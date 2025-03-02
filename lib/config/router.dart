import 'package:flutter/material.dart';
import '../presentation/views/home_screen.dart';
import '../presentation/views/match_details_screen.dart';
import '../core/constants/app_constants.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppConstants.matchDetailsRoute:
        final matchId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MatchDetailsScreen(matchId: matchId),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static Map<String, WidgetBuilder> get routes => {
    AppConstants.homeRoute: (_) => const HomeScreen(),
    AppConstants.matchDetailsRoute: (ctx) =>
        MatchDetailsScreen(matchId: ModalRoute.of(ctx)!.settings.arguments as String),
  };
}