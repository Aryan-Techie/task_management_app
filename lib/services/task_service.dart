import 'package:dio/dio.dart';

class TaskService {
  final Dio dio = Dio();

  Future<Response> getTasks() async {
    return await dio.get(
      'https://jsonplaceholder.typicode.com/todos',
    );
  }
}