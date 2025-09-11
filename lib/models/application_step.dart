class ApplicationStep {
  final String title;
  final String description;
  final DateTime? deadline;

  ApplicationStep({
    required this.title,
    required this.description,
    this.deadline,
  });

  factory ApplicationStep.fromJson(Map<String, dynamic> json) {
    return ApplicationStep(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      deadline: _parseDateTime(json['deadline']),
    );
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'deadline': deadline?.toIso8601String(),
    };
  }
}
