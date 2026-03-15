import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/audit.dart';
import '../auth/providers/auth_providers.dart';
import 'providers/audits_providers.dart';

class AuditsScreen extends ConsumerWidget {
  const AuditsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audits = ref.watch(filteredAuditsProvider);
    final selectedStatus = ref.watch(auditStatusFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assigned Audits'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authControllerProvider.notifier).logout();
              context.go('/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search by hotel or audit id',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => ref.read(auditSearchProvider.notifier).state = value,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<AuditStatus?>(
              value: selectedStatus,
              decoration: const InputDecoration(labelText: 'Filter by status'),
              items: [
                const DropdownMenuItem<AuditStatus?>(value: null, child: Text('All statuses')),
                ...AuditStatus.values.map(
                  (status) => DropdownMenuItem(value: status, child: Text(status.label)),
                ),
              ],
              onChanged: (value) => ref.read(auditStatusFilterProvider.notifier).state = value,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: audits.isEmpty
                  ? const Center(child: Text('No audits match your filters'))
                  : ListView.builder(
                      itemCount: audits.length,
                      itemBuilder: (context, index) {
                        final audit = audits[index];
                        return Card(
                          child: ListTile(
                            title: Text(audit.hotelName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Audit ${audit.id} • ${audit.status.label}'),
                                const SizedBox(height: 8),
                                LinearProgressIndicator(value: audit.progress),
                                const SizedBox(height: 4),
                                Text('${audit.answeredQuestions}/${audit.totalQuestions} answered'),
                              ],
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => context.go('/audits/${audit.id}'),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
