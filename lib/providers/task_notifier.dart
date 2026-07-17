import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task_model.dart';
import 'task_provider.dart';

final taskNotifierProvider =
    AsyncNotifierProvider<TaskNotifier, List<Task>>(TaskNotifier.new);

class TaskNotifier extends AsyncNotifier<List<Task>> {
  @override
  Future<List<Task>> build() async {
    final repository = ref.read(taskRepositoryProvider);
    return repository.getTasks();
  }

  void toggleTask(int id) {
    final currentTasks = state.value ?? [];

    final updatedTasks = currentTasks.map((task) {
      if (task.id == id) {
        return task.copyWith(
          completed: !task.completed,
        );
      }

      return task;
    }).toList();

    state = AsyncData(updatedTasks);
  }

  void addTask(String title) {
    final currentTasks = state.value ?? [];

    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch,
      userId: 1,
      title: title,
      completed: false,
    );

    state = AsyncData([
      newTask,
      ...currentTasks,
    ]);
  }

  void editTask(
    int id,
    String title,
  ) {
    final currentTasks = state.value ?? [];

    final updatedTasks = currentTasks.map((task) {
      if (task.id == id) {
        return task.copyWith(
          title: title,
        );
      }

      return task;
    }).toList();

    state = AsyncData(updatedTasks);
  }

  void deleteTask(int id) {
    final currentTasks = state.value ?? [];

    state = AsyncData(
      currentTasks
          .where((task) => task.id != id)
          .toList(),
    );
  }
}
