class AuditAnswer {
  const AuditAnswer({
    required this.id,
    required this.questionId,
    required this.auditId,
    required this.value,
    this.comment,
  });

  final String id;
  final String questionId;
  final String auditId;
  final String value;
  final String? comment;
}
