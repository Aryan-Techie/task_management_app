import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskRepository {
  final TaskService service;

  TaskRepository(this.service);

  Future<List<Task>> getTasks() async {
    final response = await service.getTasks();

    return (response.data as List)
        .map((e) => Task.fromJson(e))
        .toList();
  }
}