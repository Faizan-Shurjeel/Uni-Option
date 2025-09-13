import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/university.dart';
import '../providers/university_provider.dart';
import '../utils/theme.dart';

class UniversityCard extends StatelessWidget {
  final University university;

  const UniversityCard({
    super.key,
    required this.university,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UniversityProvider>(context);
    final isFavorite = provider.isFavorite(university);
    final theme = Theme.of(context);

    // Get upcoming deadlines for this university if it's favorited
    final upcomingDeadlines = isFavorite
        ? _getUpcomingDeadlines(university)
        : <Map<String, dynamic>>[];

    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/university-detail',
              arguments: university,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // University image with shimmer loading effect
                  Hero(
                    tag: 'university_image_${university.id}',
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: university.imageUrl.startsWith('http')
                          ? CachedNetworkImage(
                              imageUrl: university.imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/university1.png',
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              university.imageUrl.isNotEmpty
                                  ? university.imageUrl
                                  : 'assets/images/university1.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  // Gradient overlay on image
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Favorite button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, anim) => ScaleTransition(
                            scale: anim,
                            child: child,
                          ),
                          child: Icon(
                            isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            key: ValueKey(isFavorite),
                            color: isFavorite ? Colors.red : Colors.white,
                          ),
                        ),
                        onPressed: () {
                          provider.toggleFavorite(university);
                        },
                      ),
                    ),
                  ),
                  // University type chip
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.universityAccent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Text(
                        university.type,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),

                  // Deadline indicator for favorited universities
                  if (isFavorite && upcomingDeadlines.isNotEmpty)
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getDeadlineColor(
                              upcomingDeadlines.first['daysLeft']),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 12,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _getDeadlineText(
                                  upcomingDeadlines.first['daysLeft']),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      university.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: theme.colorScheme.secondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          university.location,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Programs:',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${university.programs.length} available',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: university.programs
                          .take(3)
                          .map((program) => _buildProgramChip(program, theme))
                          .toList(),
                    ),
                    if (university.programs.length > 3) ...[
                      const SizedBox(height: 4),
                      Text(
                        '+ ${university.programs.length - 3} more',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/university-detail',
                            arguments: university,
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                        label: const Text('View Details'),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgramChip(String program, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Text(
        program,
        style: TextStyle(
          fontSize: 12,
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w500,
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

      // Only include upcoming deadlines (next 30 days)
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

  Color _getDeadlineColor(int daysLeft) {
    if (daysLeft <= 3) {
      return Colors.red.shade600;
    } else if (daysLeft <= 7) {
      return Colors.orange.shade600;
    } else {
      return Colors.blue.shade600;
    }
  }

  String _getDeadlineText(int daysLeft) {
    if (daysLeft == 0) {
      return 'Today!';
    } else if (daysLeft == 1) {
      return '1 day';
    } else {
      return '$daysLeft days';
    }
  }
}
