import 'package:flutter_todo_app/data_model/task.dart';

abstract class DatabaseClient {
  Future<void> addToDb(Task task);
  Future<void> updateTask(Task task);
  List<Task> getAllTasks();
  Future<void> deleteFromDb(Task task);
}
