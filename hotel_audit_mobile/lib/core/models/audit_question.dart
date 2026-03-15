class AuditQuestion {
  const AuditQuestion({
    required this.id,
    required this.sectionId,
    required this.label,
    required this.type,
    this.isRequired = true,
  });

  final String id;
  final String sectionId;
  final String label;
  final String type;
  final bool isRequired;
}
