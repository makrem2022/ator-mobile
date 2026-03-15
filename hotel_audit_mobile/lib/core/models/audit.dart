import 'audit_answer.dart';
import 'audit_section.dart';

enum AuditStatus { draft, inProgress, completed, submitted }

extension AuditStatusLabel on AuditStatus {
  String get label {
    switch (this) {
      case AuditStatus.draft:
        return 'Draft';
      case AuditStatus.inProgress:
        return 'In progress';
      case AuditStatus.completed:
        return 'Completed';
      case AuditStatus.submitted:
        return 'Submitted';
    }
  }
}

class Audit {
  const Audit({
    required this.id,
    required this.hotelId,
    required this.hotelName,
    required this.inspectorId,
    required this.scheduledAt,
    this.startedAt,
    required this.updatedAt,
    required this.status,
    required this.sections,
    required this.answers,
  });

  final String id;
  final String hotelId;
  final String hotelName;
  final String inspectorId;
  final DateTime scheduledAt;
  final DateTime? startedAt;
  final DateTime updatedAt;
  final AuditStatus status;
  final List<AuditSection> sections;
  final Map<String, AuditAnswer> answers;

  int get totalQuestions =>
      sections.fold(0, (sum, section) => sum + section.questions.length);

  int get answeredQuestions =>
      answers.values.where((answer) => answer.isAnswered).length;

  double get progress =>
      totalQuestions == 0 ? 0 : answeredQuestions / totalQuestions;

  Audit copyWith({
    DateTime? startedAt,
    DateTime? updatedAt,
    AuditStatus? status,
    Map<String, AuditAnswer>? answers,
  }) {
    return Audit(
      id: id,
      hotelId: hotelId,
      hotelName: hotelName,
      inspectorId: inspectorId,
      scheduledAt: scheduledAt,
      startedAt: startedAt ?? this.startedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      sections: sections,
      answers: answers ?? this.answers,
    );
  }
}
