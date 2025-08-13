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
      title: json['title'],
      description: json['description'] ?? '',
      deadline: json['deadline'] != null 
          ? DateTime.parse(json['deadline']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'deadline': deadline?.toIso8601String(),
    };
  }
}