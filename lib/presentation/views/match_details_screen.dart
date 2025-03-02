import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taktiik/presentation/providers/match_provider.dart';
import 'package:taktiik/presentation/widgets/score_board.dart';
import 'package:taktiik/presentation/widgets/lineup_view.dart';

class MatchDetailsScreen extends StatefulWidget {
  final String matchId;

  const MatchDetailsScreen({super.key, required this.matchId});

  @override
  State<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {
  late final MatchProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = context.read<MatchProvider>();
    _provider.loadMatchDetails(widget.matchId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Match Details')),
      body: Consumer<MatchProvider>(
        builder: (context, provider, _) {
          final match = provider.matchDetails;

          if (match == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ScoreBoard(
                  homeScore: match.score.fullTimeHome,
                  awayScore: match.score.fullTimeAway,
                ),
                const SizedBox(height: 20),
                LineupView(
                  players: [...match.homeTeam.squad.map((player) => player.name), ...match.awayTeam.squad.map((player) => player.name)],
                ),
                // Add more match stats
              ],
            ),
          );
        },
      ),
    );
  }
}