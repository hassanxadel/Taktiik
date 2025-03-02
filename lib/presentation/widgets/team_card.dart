import 'package:flutter/material.dart';
import '../../../data/models/team.dart';

class TeamCard extends StatelessWidget {
  final Team team;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const TeamCard({
    super.key,
    required this.team,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(team.crestUrl),
        ),
        title: Text(team.name),
        subtitle: Text(team.shortName),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
          ),
          onPressed: onFavoriteToggle,
        ),
        onTap: () {
          // Navigate to team details screen
        },
      ),
    );
  }
}