import 'audit_question.dart';

class AuditAnswer {
  const AuditAnswer({
    required this.questionId,
    required this.type,
    this.yesNoValue,
    this.textValue,
    this.scoreValue,
    required this.updatedAt,
  });

  final String questionId;
  final QuestionType type;
  final bool? yesNoValue;
  final String? textValue;
  final int? scoreValue;
  final DateTime updatedAt;

  bool get isAnswered {
    switch (type) {
      case QuestionType.yesNo:
        return yesNoValue != null;
      case QuestionType.text:
        return textValue != null && textValue!.trim().isNotEmpty;
      case QuestionType.score:
        return scoreValue != null;
    }
  }

  AuditAnswer copyWith({
    bool? yesNoValue,
    String? textValue,
    int? scoreValue,
    DateTime? updatedAt,
  }) {
    return AuditAnswer(
      questionId: questionId,
      type: type,
      yesNoValue: yesNoValue ?? this.yesNoValue,
      textValue: textValue ?? this.textValue,
      scoreValue: scoreValue ?? this.scoreValue,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
