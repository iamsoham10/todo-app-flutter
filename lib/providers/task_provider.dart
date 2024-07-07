import 'package:flutter/material.dart';
import 'package:todo_app/api/api_service.dart';
import 'package:todo_app/models/task.dart';

class TaskProvider with ChangeNotifier {
  bool isLoading = true;
  List<Task> _tasks = [];

  TaskProvider() {
    fetchTask();
  }

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
    ApiService.addNewTask(task);
  }

  void toggleTaskCompletion(String id) {
    Task task = _tasks.firstWhere((task) => task.id == id);
    task.complete = !(task.complete);
    notifyListeners();
  }

  void deleteTask(Task task) {
    int indexOfTask =
        _tasks.indexOf(_tasks.firstWhere((element) => element.id == task.id));
    _tasks.removeAt(indexOfTask);
    notifyListeners();
    ApiService.deleteTask(task);
  }

  void updateTask(Task task) {
    int indexOfTask =
        _tasks.indexOf(_tasks.firstWhere((element) => element.id == task.id));
    _tasks[indexOfTask] = task;
    notifyListeners();
    ApiService.updateTask(task);
  }

  void fetchTask() async {
    _tasks = await ApiService.fetchTask("demo_user");
    isLoading = false;
    notifyListeners();
  }
}
