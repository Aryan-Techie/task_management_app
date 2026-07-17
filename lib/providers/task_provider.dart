import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task_model.dart';
import '../repository/task_repository.dart';
import '../services/task_service.dart';

final taskServiceProvider = Provider<TaskService>((ref) {
  return TaskService();
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository(
    ref.read(taskServiceProvider),
  );
});

final tasksProvider = FutureProvider<List<Task>>((ref) async {
  final repository = ref.read(taskRepositoryProvider);

  return repository.getTasks();
});