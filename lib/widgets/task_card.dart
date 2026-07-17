import 'package:flutter/material.dart';
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