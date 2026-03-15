import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/audit.dart';
import '../audits/providers/audits_providers.dart';

class AuditDetailScreen extends ConsumerWidget {
  const AuditDetailScreen({required this.auditId, super.key});

  final String auditId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audit = ref.watch(auditByIdProvider(auditId));

    if (audit == null) {
      return const Scaffold(body: Center(child: Text('Audit not found')));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Audit ${audit.id}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(audit.hotelName, style: Theme.of(context).textTheme.headlineSmall),
          Text('Status: ${audit.status.label}'),
          Text('Scheduled: ${audit.scheduledAt}'),
          if (audit.startedAt != null) Text('Started: ${audit.startedAt}'),
          Text('Updated: ${audit.updatedAt}'),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: audit.progress),
          const SizedBox(height: 8),
          Text('${audit.answeredQuestions}/${audit.totalQuestions} answered'),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => context.go('/audits/$auditId/checklist'),
            child: const Text('Open checklist'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: audit.status == AuditStatus.submitted
                ? null
                : () => ref.read(auditsControllerProvider.notifier).submitAudit(auditId),
            child: const Text('Mark as submitted'),
          ),
          const SizedBox(height: 20),
          Text('Sections', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...audit.sections.map(
            (section) {
              final answered = section.questions
                  .where((question) => audit.answers[question.id]?.isAnswered ?? false)
                  .length;
              return Card(
                child: ListTile(
                  title: Text(section.title),
                  subtitle: Text('$answered/${section.questions.length} answered'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
