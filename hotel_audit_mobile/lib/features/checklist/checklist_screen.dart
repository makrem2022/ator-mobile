import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/audit_question.dart';
import '../audits/providers/audits_providers.dart';

class ChecklistScreen extends ConsumerWidget {
  const ChecklistScreen({required this.auditId, super.key});

  final String auditId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audit = ref.watch(auditByIdProvider(auditId));

    if (audit == null) {
      return const Scaffold(body: Center(child: Text('Audit not found')));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Checklist ${audit.id}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(audit.hotelName, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: audit.progress),
          const SizedBox(height: 4),
          Text('Progress: ${(audit.progress * 100).round()}%'),
          const SizedBox(height: 16),
          ...audit.sections.map(
            (section) => Card(
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(section.title),
                children: section.questions
                    .map((question) => _QuestionField(auditId: auditId, questionId: question.id))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionField extends ConsumerWidget {
  const _QuestionField({required this.auditId, required this.questionId});

  final String auditId;
  final String questionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audit = ref.watch(auditByIdProvider(auditId));
    if (audit == null) {
      return const SizedBox.shrink();
    }

    final question = audit.sections
        .expand((section) => section.questions)
        .firstWhere((item) => item.id == questionId);
    final answer = audit.answers[question.id];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question.label, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          switch (question.type) {
            QuestionType.yesNo => SegmentedButton<bool?>(
                segments: const [
                  ButtonSegment<bool?>(value: true, label: Text('Yes')),
                  ButtonSegment<bool?>(value: false, label: Text('No')),
                ],
                selected: {
                  if (answer?.yesNoValue != null) answer!.yesNoValue!,
                },
                emptySelectionAllowed: true,
                onSelectionChanged: (selection) {
                  ref.read(auditsControllerProvider.notifier).saveAnswer(
                        auditId: auditId,
                        question: question,
                        yesNoValue: selection.isEmpty ? null : selection.first,
                      );
                },
              ),
            QuestionType.text => TextFormField(
                initialValue: answer?.textValue,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(hintText: 'Write notes here'),
                onChanged: (value) {
                  ref.read(auditsControllerProvider.notifier).saveAnswer(
                        auditId: auditId,
                        question: question,
                        textValue: value,
                      );
                },
              ),
            QuestionType.score => Row(
                children: List.generate(question.maxScore, (index) {
                  final score = index + 1;
                  return IconButton(
                    onPressed: () {
                      ref.read(auditsControllerProvider.notifier).saveAnswer(
                            auditId: auditId,
                            question: question,
                            scoreValue: score,
                          );
                    },
                    icon: Icon(
                      Icons.star,
                      color: (answer?.scoreValue ?? 0) >= score
                          ? Colors.amber
                          : Colors.grey.shade400,
                    ),
                  );
                }),
              ),
          },
        ],
      ),
    );
  }
}
