import 'package:flutter_todo_app/data_model/task.dart';
import 'package:flutter_todo_app/database/database_client.dart';

class TodoService {
  final DatabaseClient _databaseClient;

  TodoService(DatabaseClient databaseClient) : _databaseClient = databaseClient;

  Future<void> addTodo(Task task) async {
    await _databaseClient.addToDb(task);
  }

  Future<void> updateTask(Task task) async {
    await _databaseClient.updateTask(task);
  }

  List<Task> getAllTasks() {
    return _databaseClient.getAllTasks();
  }

  Future<void> deleteTask(Task task) async {
    await _databaseClient.deleteFromDb(task);
  }
}
