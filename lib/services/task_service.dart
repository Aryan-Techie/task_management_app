// TaskService only does one thing — make the HTTP request
// it doesn't know anything about the app, just fetches raw data
// keeping it separate means if I ever swap Dio for something else, I only change this file

import 'package:dio/dio.dart';

class TaskService {
  // Dio is like axios in JavaScript — makes HTTP requests easier
  final Dio dio = Dio();

  Future<Response> getTasks() async {
    // just hitting the endpoint and returning whatever comes back
    // the repository will handle parsing it into proper Task objects
    return await dio.get(
      'https://jsonplaceholder.typicode.com/todos',
    );
  }
}