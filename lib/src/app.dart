import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/database/hive_db.dart';
import 'package:flutter_todo_app/src/screens/home.dart';
import 'package:flutter_todo_app/src/services/todo_service.dart';
import 'package:flutter_todo_app/todo_bloc/todo_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoService(HiveDB()),
      child: BlocProvider(
        create: (context) => TodoBloc(service: context.read<TodoService>())
          ..add(GetAllTaskEvent()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 30, 12, 109),
            ),
          ),
          // darkTheme: ThemeData.dark(useMaterial3: true),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
