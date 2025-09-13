import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
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
          final favoriteUniversities = universityProvider.favorites;

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
    final upcomingDeadlines = _getUpcomingDeadlines(university);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                university.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(university.location),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  Provider.of<UniversityProvider>(context, listen: false)
                      .toggleFavorite(university);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Removed from favorites')),
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
            ),

            // Show deadline information
            if (upcomingDeadlines.isNotEmpty) ...[
              const Divider(),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Upcoming Deadlines:',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ...upcomingDeadlines.take(2).map((deadline) {
                final daysLeft = deadline['daysLeft'] as int;
                return Padding(
                  padding: const EdgeInsets.only(left: 24, bottom: 2),
                  child: Text(
                    '${deadline['title']}: ${DateFormat.yMMMd().format(deadline['deadline'])} ($daysLeft days)',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: daysLeft <= 7
                              ? Colors.red.shade600
                              : Colors.grey.shade600,
                        ),
                  ),
                );
              }),
              if (upcomingDeadlines.length > 2)
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    '+ ${upcomingDeadlines.length - 2} more deadlines',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getUpcomingDeadlines(University university) {
    final now = DateTime.now();
    List<Map<String, dynamic>> deadlines = [];

    for (final step in university.applicationSteps) {
      if (step.deadline == null) continue;

      final daysLeft = step.deadline!.difference(now).inDays;

      // Include upcoming deadlines (next 30 days)
      if (daysLeft >= 0 && daysLeft <= 30) {
        deadlines.add({
          'title': step.title,
          'deadline': step.deadline,
          'daysLeft': daysLeft,
        });
      }
    }

    // Sort by closest deadline first
    deadlines
        .sort((a, b) => (a['daysLeft'] as int).compareTo(b['daysLeft'] as int));

    return deadlines;
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
