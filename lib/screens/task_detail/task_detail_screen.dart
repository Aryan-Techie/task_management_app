import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/task_model.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            onPressed: () {
              context.push(
                '/edit-task',
                extra: task,
              );
    },
    icon: const Icon(Icons.edit),
  ),
],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 8),

            Text(task.title),

            const SizedBox(height: 24),

            Text(
              'Status',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 8),

            Chip(
              label: Text(
                task.completed
                    ? 'Completed'
                    : 'Pending',
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Task ID: ${task.id}',
            ),

            Text(
              'User ID: ${task.userId}',
            ),
          ],
        ),
      ),
    );
  }
}