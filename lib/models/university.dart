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
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      address: json['address'] ?? '',
      latitude: _parseDouble(json['latitude']),
      longitude: _parseDouble(json['longitude']),
      website: json['website'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'] ?? '',
      eligibilityCriteria: json['eligibility_criteria'] ?? '',
      type: json['type'] ?? '',
      degrees: _parseDegrees(json['degrees']),
      applicationSteps: _parseApplicationSteps(json['application_steps']),
      programs: _parsePrograms(json['programs']),
    );
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static List<Degree> _parseDegrees(dynamic degrees) {
    if (degrees == null) return [];
    if (degrees is! List) return [];
    return degrees
        .map((degree) =>
            degree is Map<String, dynamic> ? Degree.fromJson(degree) : null)
        .where((degree) => degree != null)
        .cast<Degree>()
        .toList();
  }

  static List<ApplicationStep> _parseApplicationSteps(dynamic steps) {
    if (steps == null) return [];
    if (steps is! List) return [];
    return steps
        .map((step) => step is Map<String, dynamic>
            ? ApplicationStep.fromJson(step)
            : null)
        .where((step) => step != null)
        .cast<ApplicationStep>()
        .toList();
  }

  static List<String> _parsePrograms(dynamic programs) {
    if (programs == null) return [];
    if (programs is List) {
      return programs.map((program) => program.toString()).toList();
    }
    return [];
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
