import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/data_model/task.dart';
import 'package:flutter_todo_app/src/widgets/add_task_sheet.dart';
import 'package:flutter_todo_app/todo_bloc/todo_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController descriptionController = TextEditingController();

  TextEditingController titleController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _addOrEditTask(BuildContext ctx, Task? task) {
    if (task != null) {
      titleController.text = task.title;
      descriptionController.text = task.description;
    }
    showModalBottomSheet(
      constraints: const BoxConstraints(),
      context: ctx,
      builder: (ctx) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: AddTaskSheet(
            titleController: titleController,
            descriptionController: descriptionController,
            task: task,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("ToDo"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addOrEditTask(context, null),
          child: const Icon(Icons.add),
        ),
        body: BlocConsumer<TodoBloc, TodoState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is TasksRetrieved) {
                final allTasks = state.tasks;
                return allTasks.isEmpty
                    ? const Center(
                        child: Text('Add a Task'),
                      )
                    : ListView.builder(
                        itemCount: allTasks.length,
                        itemBuilder: (context, index) {
                          final task = allTasks[index];
                          return ListTile(
                            title: Text(task.title),
                            subtitle: Text(task.description),
                            leading: Checkbox(
                              value: task.isDone,
                              onChanged: (value) {
                                context.read<TodoBloc>().add(UpdateTaskEvent(
                                    task.copyWith(isDone: !task.isDone)));
                              },
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      _addOrEditTask(context, task),
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () => context
                                      .read<TodoBloc>()
                                      .add(DeleteTaskEvent(task)),
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          );
                        },
                      );
              }
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }),
      ),
    );
  }
}
