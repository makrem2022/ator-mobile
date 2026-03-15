import 'audit_question.dart';

class AuditSection {
  const AuditSection({
    required this.id,
    required this.auditId,
    required this.title,
    required this.order,
    required this.questions,
  });

  final String id;
  final String auditId;
  final String title;
  final int order;
  final List<AuditQuestion> questions;
}
