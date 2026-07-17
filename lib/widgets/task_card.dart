import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          context.push(
            '/task-detail',
            extra: task,
          );
        },
        title: Text(task.title),
        trailing: IconButton(
          onPressed: onToggle,
          icon: Icon(
            task.completed
                ? Icons.check_circle
                : Icons.circle_outlined,
          ),
        ),
      ),
    );
  }
}