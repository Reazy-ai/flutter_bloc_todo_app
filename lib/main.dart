import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data_model/task.dart';
import 'package:hive_flutter/adapters.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('ToDo');

  runApp(const MyApp());
}
