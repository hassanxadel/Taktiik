import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taktiik/presentation/providers/match_provider.dart';
import 'package:taktiik/presentation/widgets/match_card.dart';
import 'package:taktiik/presentation/widgets/loading_indicator.dart';
import 'package:taktiik/presentation/widgets/error_view.dart';
import 'package:taktiik/presentation/widgets/custom_app_bar.dart';
import 'package:taktiik/presentation/views/match_details_screen.dart';
import 'package:taktiik/data/models/match.dart' as app_models;


class UpcomingMatchesScreen extends StatefulWidget {
  const UpcomingMatchesScreen({super.key});

  @override
  State<UpcomingMatchesScreen> createState() => _UpcomingMatchesScreenState();
}

class _UpcomingMatchesScreenState extends State<UpcomingMatchesScreen> {
  late final MatchProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = context.read<MatchProvider>();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    if (_provider.upcomingMatches.isEmpty) {
      await _provider.loadUpcomingMatches();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Upcoming Matches',
        actions: [SizedBox.shrink()], // Empty container to maintain layout
      ),
      body: Consumer<MatchProvider>(
        builder: (context, provider, _) {
          if (provider.error != null) {
            return ErrorView(
              message: provider.error!,
              onRetry: () => provider.loadUpcomingMatches(),
            );
          }

          if (provider.isLoading && provider.upcomingMatches.isEmpty) {
            return const LoadingIndicator();
          }

          return RefreshIndicator(
            onRefresh: () => provider.loadUpcomingMatches(),
            child: _buildContent(provider),
          );
        },
      ),
    );
  }

  Widget _buildContent(MatchProvider provider) {
    if (provider.upcomingMatches.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.event_available, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No upcoming matches scheduled',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: provider.upcomingMatches.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final match = provider.upcomingMatches[index];
        return MatchCard(
          match: match,
          onTap: () => _navigateToMatchDetails(context, match),
        );
      },
    );
  }

  void _navigateToMatchDetails(BuildContext context, app_models.Match match) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MatchDetailsScreen(matchId: match.id),
      ),
    );
  }
}