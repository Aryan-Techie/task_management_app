// reusable card for displaying a task in the list
// tapping goes to task detail, the icon on the right toggles complete/incomplete
// onToggle is passed in from HomeScreen so this widget stays dumb (no ref needed)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle; // callback so the parent handles the state change

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
          // pass the full task object to the detail screen via extra
          context.push(
            '/task-detail',
            extra: task,
          );
        },
        title: Text(task.title),
        trailing: IconButton(
          onPressed: onToggle,
          // icon changes based on whether the task is done or not
          icon: Icon(
            task.completed
                ? Icons.check_circle      // done
                : Icons.circle_outlined,  // not done yet
          ),
        ),
      ),
    );
  }
}