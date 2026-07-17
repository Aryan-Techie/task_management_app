// shows the full details of a single task
// the task object is passed in from HomeScreen via GoRouter's state.extra
// ConsumerWidget is needed here because we call ref.read to delete

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/task_model.dart';
import '../../providers/task_notifier.dart';

class TaskDetailScreen extends ConsumerWidget {
  final Task task;

  const TaskDetailScreen({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          // delete button — removes task and goes back to home
          IconButton(
            onPressed: () {
              ref
                  .read(taskNotifierProvider.notifier)
                  .deleteTask(task.id);

              context.pop(); // go back after deleting
            },
            icon: const Icon(Icons.delete),
          ),

          // edit button — navigates to edit screen, passing the task as extra
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

            // chip changes label based on completed status
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