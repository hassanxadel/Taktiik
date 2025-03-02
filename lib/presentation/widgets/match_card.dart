import 'package:flutter/material.dart';
import '../../../data/models/match.dart';

class MatchCard extends StatelessWidget {
  final Match match;
  final VoidCallback onTap;

  const MatchCard({super.key, required this.match, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: const Icon(Icons.sports_soccer),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(match.homeTeam.name),
            Text('${match.score.fullTimeHome} - ${match.score.fullTimeAway}'),
            Text(match.awayTeam.name),
          ],
        ),
        subtitle: Text(
          '${match.competition.name} • ${match.status}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}