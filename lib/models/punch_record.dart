class PunchRecord {
  final String project;
  final String developed;
  final String description;
  final String totalHours;
  final DateTime timestamp;

  const PunchRecord({
    required this.project,
    required this.developed,
    required this.description,
    required this.totalHours,
    required this.timestamp,
  });

  @override
  String toString() => 'PunchRecord('
      'project: $project, '
      'developed: $developed, '
      'description: $description, '
      'totalHours: $totalHours, '
      'timestamp: $timestamp)';
}
