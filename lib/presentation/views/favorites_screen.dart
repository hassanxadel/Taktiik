import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../presentation/providers/favorites_provider.dart';
import '../../../presentation/widgets/custom_app_bar.dart';
import '../../../presentation/widgets/team_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Favorite Teams'),
      body: Consumer<FavoritesProvider>(
        builder: (context, provider, _) {
          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }

          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.favoriteTeams.isEmpty) {
            return const Center(child: Text('No favorite teams added yet!'));
          }

          return RefreshIndicator(
            onRefresh: () => provider.loadFavorites(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.favoriteTeams.length,
              itemBuilder: (context, index) => TeamCard(
                team: provider.favoriteTeams[index],
                isFavorite: true,
                onFavoriteToggle: () => provider.toggleFavorite(
                    provider.favoriteTeams[index]
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}