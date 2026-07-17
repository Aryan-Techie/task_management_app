// Repository sits between the service and the provider
// its job is to take the raw HTTP response and turn it into a list of Task objects
// the provider never talks to the service directly — it always goes through here

import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskRepository {
  final TaskService service;

  TaskRepository(this.service);

  Future<List<Task>> getTasks() async {
    final response = await service.getTasks();

    // response.data comes back as a dynamic List (raw JSON array)
    // casting it and mapping each item through Task.fromJson to get proper objects
    return (response.data as List)
        .map((e) => Task.fromJson(e))
        .toList();
  }
}