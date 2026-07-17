import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/task_notifier.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({super.key});

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final titleController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
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
              text: 'Save Task',
              onPressed: () {
                if (titleController.text.trim().isEmpty) return;

                ref
                    .read(taskNotifierProvider.notifier)
                    .addTask(titleController.text.trim());

                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}