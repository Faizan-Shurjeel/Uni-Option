import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UniversityMapWidget extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String universityName;

  const UniversityMapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.universityName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                size: 48,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                universityName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Lat: $latitude, Long: $longitude',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          icon: const Icon(
            Icons.directions,
            color: Colors.white,
          ),
          label: const Text('View on Google Maps'),
          onPressed: () => _launchMaps(),
        ),
      ],
    );
  }

  Future<void> _launchMaps() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch maps');
    }
  }
}
