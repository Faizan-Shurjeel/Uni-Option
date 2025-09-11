class Degree {
  final String id;
  final String name;
  final String description;
  final int duration;
  final List<String> requirements;
  final List<String> careerOptions;
  final double fee;

  Degree({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.requirements,
    required this.careerOptions,
    required this.fee,
  });

  factory Degree.fromJson(Map<String, dynamic> json) {
    return Degree(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      duration: _parseInt(json['duration']),
      requirements: _parseStringList(json['requirements']),
      careerOptions: _parseStringList(json['career_options']),
      fee: _parseDouble(json['fee']),
    );
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static List<String> _parseStringList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map((item) => item.toString()).toList();
    }
    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'duration': duration,
      'requirements': requirements,
      'careerOptions': careerOptions,
      'fee': fee,
    };
  }
}
