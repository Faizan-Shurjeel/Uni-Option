import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/university.dart';
import '../providers/university_provider.dart';
import '../widgets/contact_info_widget.dart';
import '../widgets/application_steps_widget.dart';
import '../widgets/degree_list_item.dart';
import '../widgets/university_map_widget.dart';

class UniversityDetailScreen extends StatelessWidget {
  final University university;

  const UniversityDetailScreen({super.key, required this.university});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(university.name),
        actions: [
          Consumer<UniversityProvider>(
            builder: (context, universityProvider, child) {
              final isFavorite = universityProvider.isFavorite(university);
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  universityProvider.toggleFavorite(university);
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // University Image
            if (university.imageUrl.isNotEmpty)
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(university.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // University Name and Type
            Text(
              university.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Chip(
              label: Text(university.type),
              backgroundColor: university.type == 'Public'
                  ? Colors.green.withOpacity(0.2)
                  : Colors.blue.withOpacity(0.2),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              'About',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              university.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),

            // Contact Information
            ContactInfoWidget(
              phone: university.phoneNumber,
              email: university.email,
              website: university.website,
            ),
            const SizedBox(height: 24),

            // Programs Offered
            Text(
              'Programs Offered',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: university.programs
                  .map((program) => Chip(
                        label: Text(program),
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.1),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 24),

            // Degrees
            if (university.degrees.isNotEmpty) ...[
              Text(
                'Available Degrees',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              ...university.degrees
                  .map((degree) => DegreeListItem(degree: degree)),
              const SizedBox(height: 24),
            ],

            // Application Steps
            if (university.applicationSteps.isNotEmpty) ...[
              Text(
                'Application Process & Deadlines',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              ApplicationStepsWidget(steps: university.applicationSteps),

              // Add deadline summary
              const SizedBox(height: 16),
              _buildDeadlineSummary(context, university),
              const SizedBox(height: 24),
            ],

            // Eligibility Criteria
            Text(
              'Eligibility Criteria',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              university.eligibilityCriteria,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),

            // Map
            if (university.latitude != 0 && university.longitude != 0) ...[
              Text(
                'Location',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              UniversityMapWidget(
                latitude: university.latitude,
                longitude: university.longitude,
                universityName: university.name,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDeadlineSummary(BuildContext context, University university) {
    final now = DateTime.now();
    final upcomingDeadlines = university.applicationSteps
        .where((step) => step.deadline != null && step.deadline!.isAfter(now))
        .toList();

    final pastDeadlines = university.applicationSteps
        .where((step) => step.deadline != null && step.deadline!.isBefore(now))
        .toList();

    if (upcomingDeadlines.isEmpty && pastDeadlines.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deadline Summary',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            if (upcomingDeadlines.isNotEmpty) ...[
              Text(
                'Upcoming Deadlines:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade700,
                    ),
              ),
              const SizedBox(height: 8),
              ...upcomingDeadlines.map((step) {
                final daysLeft = step.deadline!.difference(now).inDays;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: daysLeft <= 7 ? Colors.red : Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${step.title}: ${DateFormat.yMMMd().format(step.deadline!)} ($daysLeft days)',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 16),
            ],
            if (pastDeadlines.isNotEmpty) ...[
              Text(
                'Recent Past Deadlines:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
              ),
              const SizedBox(height: 8),
              ...pastDeadlines.take(3).map((step) {
                final daysPast = now.difference(step.deadline!).inDays;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.history,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${step.title}: ${DateFormat.yMMMd().format(step.deadline!)} ($daysPast days ago)',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}
