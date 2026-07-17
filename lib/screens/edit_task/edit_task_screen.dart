import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/task_model.dart';
import '../../providers/task_notifier.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';

class EditTaskScreen extends ConsumerStatefulWidget {
  final Task task;

  const EditTaskScreen({super.key, required this.task});

  @override
  ConsumerState<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends ConsumerState<EditTaskScreen> {
  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.task.title);
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(
              controller: titleController,
              label: 'Task Title',
            ),

            const SizedBox(height: 20),

            PrimaryButton(
              text: 'Update Task',
              onPressed: () {
                ref
                    .read(taskNotifierProvider.notifier)
                    .editTask(
                      widget.task.id,
                      titleController.text,
                    );

                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
