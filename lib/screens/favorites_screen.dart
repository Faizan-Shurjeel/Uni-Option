import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/university_provider.dart';
import '../models/university.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Consumer<UniversityProvider>(
        builder: (context, universityProvider, child) {
          final List<University> favoriteUniversities =
              universityProvider.favorites;

          return favoriteUniversities.isEmpty
              ? const Center(
                  child: EmptyFavorites(), // Custom widget for empty state
                )
              : ListView.builder(
                  itemCount: favoriteUniversities.length,
                  itemBuilder: (context, index) {
                    final university = favoriteUniversities[index];
                    return FavoriteUniversityTile(
                      key: ValueKey(university.id),
                      university: university,
                    );
                  },
                );
        },
      ),
    );
  }
}

class FavoriteUniversityTile extends StatelessWidget {
  const FavoriteUniversityTile({
    super.key,
    required this.university,
  });

  final University university;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(university.name),
      subtitle: Text(university.location),
      trailing: IconButton(
        icon: const Icon(Icons.favorite, color: Colors.red),
        onPressed: () {
          Provider.of<UniversityProvider>(context, listen: false)
              .toggleFavorite(university.id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Favorite toggled')),
          );
        },
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/university-detail',
          arguments: university,
        );
      },
    );
  }
}

class EmptyFavorites extends StatelessWidget {
  const EmptyFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 40),
          Text('No favorites yet!'),
        ],
      ),
    );
  }
}
