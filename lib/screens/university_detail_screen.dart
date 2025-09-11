import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/university.dart';
import '../providers/university_provider.dart';
import '../widgets/contact_info_widget.dart';
import '../widgets/application_steps_widget.dart';
import '../widgets/degree_list_item.dart';
import '../widgets/university_map_widget.dart';

class UniversityDetailScreen extends StatelessWidget {
  final University university;

  const UniversityDetailScreen({Key? key, required this.university})
      : super(key: key);

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
                'Application Process',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              ApplicationStepsWidget(steps: university.applicationSteps),
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
}
