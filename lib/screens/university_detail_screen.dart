import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/university.dart';
import '../providers/university_provider.dart';
import '../widgets/degree_list_item.dart';
import '../widgets/application_steps_widget.dart';
import '../widgets/university_map_widget.dart';
import '../widgets/contact_info_widget.dart';

class UniversityDetailScreen extends StatelessWidget {
  const UniversityDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments;

    // Handle both cases - receiving a University object or just the ID
    University university;
    if (argument is University) {
      university = argument;
    } else if (argument is String) {
      final universityProvider =
          Provider.of<UniversityProvider>(context, listen: false);
      university = universityProvider.getUniversityById(argument)!;
    } else {
      throw ArgumentError('Invalid argument type for UniversityDetailScreen');
    }

    final universityProvider = Provider.of<UniversityProvider>(context);
    final isFavorite = universityProvider.isFavorite(university.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(university.name),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              universityProvider.toggleFavorite(university.id);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // University Image
            if (university.imageUrl.isNotEmpty)
              _buildImageSection(university.imageUrl),

            // University Information
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAboutSection(context, university),
                  const SizedBox(height: 24),
                  _buildDegreesSection(context, university),
                  const SizedBox(height: 24),
                  _buildEligibilitySection(context, university),
                  const SizedBox(height: 24),
                  _buildApplicationSection(context, university),
                  const SizedBox(height: 24),
                  _buildContactSection(context, university),
                  const SizedBox(height: 24),
                  _buildLocationSection(context, university),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(String imageUrl) {
    return Image.network(
      imageUrl,
      width: double.infinity,
      height: 200,
      fit: BoxFit.cover,
      errorBuilder: (ctx, obj, stack) => Image.asset(
        'assets/images/university_placeholder.png',
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context, University university) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(university.description),
      ],
    );
  }

  Widget _buildDegreesSection(BuildContext context, University university) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Degrees',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        ...university.degrees.map((degree) => DegreeListItem(degree: degree)),
      ],
    );
  }

  Widget _buildEligibilitySection(BuildContext context, University university) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Eligibility Criteria',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(university.eligibilityCriteria),
      ],
    );
  }

  Widget _buildApplicationSection(BuildContext context, University university) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Application Process',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        ApplicationStepsWidget(steps: university.applicationSteps),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context, University university) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        ContactInfoWidget(
          phone: university.phoneNumber,
          email: university.email,
          website: university.website,
        ),
      ],
    );
  }

  Widget _buildLocationSection(BuildContext context, University university) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(university.address),
        const SizedBox(height: 16),
        UniversityMapWidget(
          latitude: university.latitude,
          longitude: university.longitude,
          universityName: university.name,
        ),
      ],
    );
  }
}
