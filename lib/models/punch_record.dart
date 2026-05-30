import 'package:hive/hive.dart';

part 'punch_record.g.dart';

@HiveType(typeId: 0)
class PunchRecord {
  @HiveField(0)
  final String project;

  @HiveField(1)
  final String developed;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String totalHours;

  @HiveField(4)
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
