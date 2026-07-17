// TaskNotifier is the brain of the app
// it holds the list of tasks and has all the methods that change that list
// any widget that watches taskNotifierProvider will rebuild automatically when state changes

// AsyncNotifier is the Riverpod 3 way of doing this
// StateNotifier was removed in v3 — learned that the hard way

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task_model.dart';
import 'task_provider.dart';

// the provider itself — this is what screens watch/read
final taskNotifierProvider =
    AsyncNotifierProvider<TaskNotifier, List<Task>>(TaskNotifier.new);

class TaskNotifier extends AsyncNotifier<List<Task>> {
  // build() runs automatically when the provider is first accessed
  // it's like an init — fetches the tasks from the API
  @override
  Future<List<Task>> build() async {
    final repository = ref.read(taskRepositoryProvider);
    return repository.getTasks();
  }

  // flips the completed status of a task
  // using copyWith so I don't mutate the original object
  void toggleTask(int id) {
    final currentTasks = state.value ?? [];

    final updatedTasks = currentTasks.map((task) {
      if (task.id == id) {
        // flip it
        return task.copyWith(
          completed: !task.completed,
        );
      }

      return task; // leave everything else unchanged
    }).toList();

    state = AsyncData(updatedTasks);
  }

  // adds a new task to the top of the list
  // using millisecondsSinceEpoch as a quick unique ID since we're not hitting a real backend
  void addTask(String title) {
    final currentTasks = state.value ?? [];

    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch,
      userId: 1,
      title: title,
      completed: false,
    );

    // new task goes at the top, spread the rest after
    state = AsyncData([
      newTask,
      ...currentTasks,
    ]);
  }

  // updates just the title of a task, everything else stays the same
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

  // filters out the task with this id — effectively deletes it from the list
  void deleteTask(int id) {
    final currentTasks = state.value ?? [];

    state = AsyncData(
      currentTasks
          .where((task) => task.id != id)
          .toList(),
    );
  }
}
