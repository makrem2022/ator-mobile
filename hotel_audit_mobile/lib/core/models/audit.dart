class Audit {
  const Audit({
    required this.id,
    required this.hotelId,
    required this.inspectorId,
    required this.scheduledAt,
    required this.status,
  });

  final String id;
  final String hotelId;
  final String inspectorId;
  final DateTime scheduledAt;
  final String status;
}
