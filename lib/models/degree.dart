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
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      duration: json['duration'],
      requirements: List<String>.from(json['requirements'] ?? []),
      careerOptions: List<String>.from(json['careerOptions'] ?? []),
      fee: (json['fee'] ?? 0).toDouble(),
    );
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