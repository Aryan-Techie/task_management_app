// these two providers just create instances of the service and repository
// so Riverpod can manage them and inject them wherever needed
// taskRepositoryProvider depends on taskServiceProvider — that's why it reads it with ref.read

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/task_repository.dart';
import '../services/task_service.dart';

// creates a single instance of TaskService for the whole app
final taskServiceProvider = Provider<TaskService>((ref) {
  return TaskService();
});

// creates a single instance of TaskRepository, passing in the service
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository(
    ref.read(taskServiceProvider),
  );
});