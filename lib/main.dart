import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taktiik/config/theme.dart';
import 'package:taktiik/config/router.dart';
import 'package:taktiik/services/notification_service.dart';
import 'package:taktiik/config/providers.dart';

class AppConstants {
  static const String appName = 'Taktiik';
  static const String homeRoute = '/';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notifications
  await NotificationService.initialize();

  runApp(
    MultiProvider(
      providers: appProviders,
      child: const FootballApp(),
    ),
  );
}

class FootballApp extends StatelessWidget {
  const FootballApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.system,
      initialRoute: AppConstants.homeRoute,
      onGenerateRoute: AppRouter.generateRoute,
      routes: AppRouter.routes,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
    );
  }
}