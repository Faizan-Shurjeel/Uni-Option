import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/university_provider.dart';
import '../models/university.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final universityProvider = Provider.of<UniversityProvider>(context);
    final List<University> favoriteUniversities = universityProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoriteUniversities.isEmpty
          ? const Center(
              child: Text('No favorites yet!'),
            )
          : ListView.builder(
              itemCount: favoriteUniversities.length,
              itemBuilder: (context, index) {
                final university = favoriteUniversities[index];
                return ListTile(
                  title: Text(university.name),
                  subtitle: Text(university.location),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      universityProvider.toggleFavorite(university.id);
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
              },
            ),
    );
  }
}
