import 'dart:convert';
import 'dart:developer';
import 'package:todo_app/models/task.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String _baseUrl = "https://todo-app-backend-8o9w.onrender.com";

  static Future<void> addNewTask(Task task) async {
    Uri requestUri = Uri.parse(_baseUrl + "/add");
    try {
      var response = await http.post(
        requestUri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(task.toMap()),
      );

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        log('Task added: ${decode.toString()}');
      } else {
        log('Failed to add task. Status code: ${response.statusCode}');
        log('Response body: ${response.body}');
      }
    } catch (e) {
      log('Exception occurred while adding task: $e');
    }
  }

  static Future<void> deleteTask(Task task) async {
    Uri requestUri = Uri.parse(_baseUrl + "/delete");
    var response = await http.post(requestUri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(task.toMap()));
    var decode = jsonDecode(response.body);
    log(decode.toString());
  }

  static Future<void> updateTask(Task task) async {
    Uri requestUri = Uri.parse(_baseUrl + "/add");
    var response = await http.post(requestUri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(task.toMap()));
    var decode = jsonDecode(response.body);
    log(decode.toString());
  }

  static Future<List<Task>> fetchTask(String userid) async {
    Uri requestUri = Uri.parse(_baseUrl + "/list");
    var response = await http.post(requestUri, body: {"userid": userid});
    var decode = jsonDecode(response.body);
    List<Task> tasks = [];
    for (var mapTask in decode) {
      Task newTask = Task.fromMap(mapTask);
      tasks.add(newTask);
    }
    return tasks;
  }
}
