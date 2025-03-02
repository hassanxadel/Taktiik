import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taktiik/presentation/providers/match_provider.dart';
import 'package:taktiik/presentation/widgets/match_card.dart';
import 'package:taktiik/presentation/widgets/error_view.dart';
import 'package:taktiik/presentation/widgets/loading_indicator.dart';
import 'package:taktiik/data/models/match.dart' as app_models;
import 'package:taktiik/presentation/views/match_details_screen.dart';



class LiveMatchesScreen extends StatelessWidget {
  const LiveMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Matches'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<MatchProvider>().loadLiveMatches(),
          ),
        ],
      ),
      body: Consumer<MatchProvider>(
        builder: (context, provider, _) {
          if (provider.error != null) {
            return ErrorView(
              message: provider.error!,
              onRetry: () => context.read<MatchProvider>().loadLiveMatches(),
            );
          }

          if (provider.isLoading) {
            return const LoadingIndicator();
          }

          return RefreshIndicator(
            onRefresh: () => provider.loadLiveMatches(),
            child: ListView.builder(
              itemCount: provider.liveMatches.length,
              itemBuilder: (ctx, index) => MatchCard(
                match: provider.liveMatches[index],
                onTap: () => _navigateToMatchDetail(context, provider.liveMatches[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToMatchDetail(BuildContext context, app_models.Match match) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MatchDetailsScreen(matchId: match.id),
      ),
    );
  }
}