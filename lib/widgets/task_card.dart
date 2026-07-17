import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({
    super.key,
    required this.task,
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
        trailing: Icon(
          task.completed
              ? Icons.check_circle
              : Icons.circle_outlined,
        ),
      ),
    );
  }
}