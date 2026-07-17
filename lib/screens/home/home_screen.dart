import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/task_provider.dart';
import '../../widgets/task_card.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/error_widget_custom.dart';
import '../../widgets/empty_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: tasks.when(
        data: (data) {
          if (data.isEmpty) {
            return const EmptyWidget();
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final task = data[index];

              return TaskCard(
                task: task,
              );
            },
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, stackTrace) => ErrorWidgetCustom(
          message: error.toString(),
        ),
      ),
    
    floatingActionButton: FloatingActionButton(
  onPressed: () {
    context.push('/add-task');
  },
  child: const Icon(Icons.add),
),
    
    );
  }
}