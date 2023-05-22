import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:flutter_todo_app/data_model/task.dart';
import 'package:flutter_todo_app/database/database_client.dart';

class HiveDB implements DatabaseClient {
  final Box<Task> _storageBox = Hive.box<Task>('ToDo');

  @override
  Future<void> addToDb(Task task) async {
    await _storageBox.put(task.id, task);
  }

  @override
  Future<void> deleteFromDb(Task task) async {
    await task.delete();
  }

  @override
  List<Task> getAllTasks() {
    return _storageBox.values.toList().cast<Task>();
  }

  @override
  Future<void> updateTask(Task task) async {
    await _storageBox.put(task.id, task);
  }
}
