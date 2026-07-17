// main screen — shows the list of all tasks
// ConsumerWidget gives access to ref so we can watch the task provider
// whenever the task list changes, this screen rebuilds automatically

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/task_notifier.dart';
import '../../widgets/task_card.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/error_widget_custom.dart';
import '../../widgets/empty_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch means: re-render this widget whenever taskNotifierProvider changes
    // tasks is an AsyncValue — it wraps loading, error, and data in one type
    final tasks = ref.watch(taskNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),

      // .when() handles all three states cleanly — no manual if/else needed
      body: tasks.when(
        data: (data) {
          // show empty state if there's nothing to display
          if (data.isEmpty) {
            return const EmptyWidget();
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final task = data[index];

              return TaskCard(
                task: task,
                onToggle: () {
                  // using ref.read here because this is inside a callback, not build()
                  ref
                      .read(taskNotifierProvider.notifier)
                      .toggleTask(task.id);
                },
              );
            },
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, stackTrace) => ErrorWidgetCustom(
          message: error.toString(),
        ),
      ),

      // + button in the bottom right to add a new task
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add-task');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}