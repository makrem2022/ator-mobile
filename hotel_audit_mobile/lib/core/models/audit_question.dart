enum QuestionType { yesNo, text, score }

class AuditQuestion {
  const AuditQuestion({
    required this.id,
    required this.sectionId,
    required this.label,
    required this.type,
    this.isRequired = true,
    this.maxScore = 5,
  });

  final String id;
  final String sectionId;
  final String label;
  final QuestionType type;
  final bool isRequired;
  final int maxScore;
}
