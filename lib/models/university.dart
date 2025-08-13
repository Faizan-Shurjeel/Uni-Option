import 'degree.dart';
import 'application_step.dart';

class University {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String address;
  final String location; // Added to fix references in other files
  final double latitude;
  final double longitude;
  final String website;
  final String phoneNumber;
  final String email;
  final String eligibilityCriteria;
  final List<Degree> degrees;
  final List<String> programs; // Added to fix filtering functionality
  final List<ApplicationStep> applicationSteps;
  final String type; // Added to fix missing type property

  University({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.website,
    required this.phoneNumber,
    required this.email,
    required this.eligibilityCriteria,
    required this.degrees,
    required this.applicationSteps,
    String? location, // Optional parameter to maintain backward compatibility
    List<String>?
        programs, // Optional parameter to maintain backward compatibility
    this.type = 'University', // Default value for type
  })  : location = location ?? address,
        programs = programs ?? degrees.map((d) => d.name).toList();

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      address: json['address'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      website: json['website'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      eligibilityCriteria: json['eligibilityCriteria'] ?? '',
      degrees: (json['degrees'] as List?)
              ?.map((degree) => Degree.fromJson(degree))
              .toList() ??
          [],
      applicationSteps: (json['applicationSteps'] as List?)
              ?.map((step) => ApplicationStep.fromJson(step))
              .toList() ??
          [],
      location: json['location'],
      programs: (json['programs'] as List?)?.cast<String>() ?? [],
      type: json['type'] ?? 'University',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'website': website,
      'phoneNumber': phoneNumber,
      'email': email,
      'eligibilityCriteria': eligibilityCriteria,
      'degrees': degrees.map((degree) => degree.toJson()).toList(),
      'applicationSteps':
          applicationSteps.map((step) => step.toJson()).toList(),
      'location': location,
      'programs': programs,
      'type': type,
    };
  }
}
