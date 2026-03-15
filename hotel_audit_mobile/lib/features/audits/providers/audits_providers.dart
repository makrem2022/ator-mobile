import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/audit.dart';
import '../../../core/models/audit_answer.dart';
import '../../../core/models/audit_question.dart';
import '../../../core/repositories/mock_audits_repository.dart';

final mockAuditsRepositoryProvider = Provider<MockAuditsRepository>((ref) {
  return MockAuditsRepository();
});

class AuditsController extends StateNotifier<List<Audit>> {
  AuditsController(MockAuditsRepository repository) : super(repository.fetchAudits());

  void saveAnswer({
    required String auditId,
    required AuditQuestion question,
    bool? yesNoValue,
    String? textValue,
    int? scoreValue,
  }) {
    state = [
      for (final audit in state)
        if (audit.id == auditId)
          _updateAuditAnswer(
            audit: audit,
            question: question,
            yesNoValue: yesNoValue,
            textValue: textValue,
            scoreValue: scoreValue,
          )
        else
          audit,
    ];
  }

  void submitAudit(String auditId) {
    state = [
      for (final audit in state)
        if (audit.id == auditId)
          audit.copyWith(status: AuditStatus.submitted, updatedAt: DateTime.now())
        else
          audit,
    ];
  }

  Audit _updateAuditAnswer({
    required Audit audit,
    required AuditQuestion question,
    bool? yesNoValue,
    String? textValue,
    int? scoreValue,
  }) {
    final answer = AuditAnswer(
      questionId: question.id,
      type: question.type,
      yesNoValue: question.type == QuestionType.yesNo ? yesNoValue : null,
      textValue: question.type == QuestionType.text ? textValue : null,
      scoreValue: question.type == QuestionType.score ? scoreValue : null,
      updatedAt: DateTime.now(),
    );

    final nextAnswers = Map<String, AuditAnswer>.from(audit.answers)..[question.id] = answer;

    final progress = nextAnswers.values.where((element) => element.isAnswered).length /
        (audit.totalQuestions == 0 ? 1 : audit.totalQuestions);

    final updatedStatus = switch (audit.status) {
      AuditStatus.submitted => AuditStatus.submitted,
      _ when progress >= 1 => AuditStatus.completed,
      _ when progress > 0 => AuditStatus.inProgress,
      _ => AuditStatus.draft,
    };

    return audit.copyWith(
      answers: nextAnswers,
      startedAt: audit.startedAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
      status: updatedStatus,
    );
  }
}

final auditsControllerProvider =
    StateNotifierProvider<AuditsController, List<Audit>>((ref) {
  final repository = ref.watch(mockAuditsRepositoryProvider);
  return AuditsController(repository);
});

final auditSearchProvider = StateProvider<String>((ref) => '');
final auditStatusFilterProvider = StateProvider<AuditStatus?>((ref) => null);

final filteredAuditsProvider = Provider<List<Audit>>((ref) {
  final audits = ref.watch(auditsControllerProvider);
  final search = ref.watch(auditSearchProvider).trim().toLowerCase();
  final statusFilter = ref.watch(auditStatusFilterProvider);

  return audits.where((audit) {
    final matchesSearch = search.isEmpty ||
        audit.id.toLowerCase().contains(search) ||
        audit.hotelName.toLowerCase().contains(search);
    final matchesStatus = statusFilter == null || audit.status == statusFilter;
    return matchesSearch && matchesStatus;
  }).toList();
});

final auditByIdProvider = Provider.family<Audit?, String>((ref, auditId) {
  final audits = ref.watch(auditsControllerProvider);
  for (final audit in audits) {
    if (audit.id == auditId) {
      return audit;
    }
  }
  return null;
});
