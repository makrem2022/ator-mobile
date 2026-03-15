import '../models/audit.dart';
import '../models/audit_answer.dart';
import '../models/audit_question.dart';
import '../models/audit_section.dart';

class MockAuditsRepository {
  List<Audit> fetchAudits() {
    final now = DateTime.now();

    return [
      _buildAudit('A-1001', 'Grand Horizon Paris', now.subtract(const Duration(days: 1)), AuditStatus.inProgress),
      _buildAudit('A-1002', 'Riverside Suites Lyon', now.subtract(const Duration(days: 2)), AuditStatus.draft),
      _buildAudit('A-1003', 'Oceanview Resort Nice', now.subtract(const Duration(days: 3)), AuditStatus.completed),
      _buildAudit('A-1004', 'Urban Loft Marseille', now.subtract(const Duration(days: 1)), AuditStatus.submitted),
      _buildAudit('A-1005', 'Alpine Retreat Chamonix', now, AuditStatus.draft),
      _buildAudit('A-1006', 'City Center Inn Bordeaux', now.add(const Duration(days: 1)), AuditStatus.inProgress),
    ];
  }

  Audit _buildAudit(String id, String hotelName, DateTime scheduledAt, AuditStatus status) {
    final sections = _buildSections(id);
    final initialAnswers = <String, AuditAnswer>{};

    if (status != AuditStatus.draft) {
      final sampleQuestion = sections.first.questions.first;
      initialAnswers[sampleQuestion.id] = AuditAnswer(
        questionId: sampleQuestion.id,
        type: sampleQuestion.type,
        yesNoValue: true,
        updatedAt: DateTime.now().subtract(const Duration(hours: 6)),
      );
    }

    if (status == AuditStatus.completed || status == AuditStatus.submitted) {
      for (final section in sections) {
        for (final question in section.questions) {
          initialAnswers[question.id] = _defaultAnswer(question);
        }
      }
    }

    return Audit(
      id: id,
      hotelId: 'H-$id',
      hotelName: hotelName,
      inspectorId: 'inspector-001',
      scheduledAt: scheduledAt,
      startedAt: status == AuditStatus.draft ? null : scheduledAt,
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      status: status,
      sections: sections,
      answers: initialAnswers,
    );
  }

  List<AuditSection> _buildSections(String auditId) {
    final sections = [
      ('general', 'General condition'),
      ('room', 'Room quality'),
      ('safety', 'Safety & compliance'),
    ];

    return List.generate(sections.length, (index) {
      final (prefix, title) = sections[index];
      final sectionId = '$auditId-$prefix';
      return AuditSection(
        id: sectionId,
        auditId: auditId,
        title: title,
        order: index,
        questions: [
          AuditQuestion(
            id: '$sectionId-q1',
            sectionId: sectionId,
            label: 'Is this area clean and ready for guests?',
            type: QuestionType.yesNo,
          ),
          AuditQuestion(
            id: '$sectionId-q2',
            sectionId: sectionId,
            label: 'Add an observation note',
            type: QuestionType.text,
          ),
          AuditQuestion(
            id: '$sectionId-q3',
            sectionId: sectionId,
            label: 'Quality score',
            type: QuestionType.score,
            maxScore: 5,
          ),
        ],
      );
    });
  }

  AuditAnswer _defaultAnswer(AuditQuestion question) {
    switch (question.type) {
      case QuestionType.yesNo:
        return AuditAnswer(
          questionId: question.id,
          type: question.type,
          yesNoValue: true,
          updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        );
      case QuestionType.text:
        return AuditAnswer(
          questionId: question.id,
          type: question.type,
          textValue: 'All checks are compliant.',
          updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        );
      case QuestionType.score:
        return AuditAnswer(
          questionId: question.id,
          type: question.type,
          scoreValue: 4,
          updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        );
    }
  }
}
