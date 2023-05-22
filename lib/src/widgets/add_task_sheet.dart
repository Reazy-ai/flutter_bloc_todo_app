import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/data_model/task.dart';
import 'package:flutter_todo_app/todo_bloc/todo_bloc.dart';
import 'package:uuid/uuid.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({
    super.key,
    required this.titleController,
    required this.descriptionController,
    this.task,
  });

  final Task? task;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  late FocusNode descriptionFocusNode;

  @override
  void initState() {
    super.initState();
    descriptionFocusNode = FocusNode();
  }

  @override
  void dispose() {
    descriptionFocusNode.dispose();
    super.dispose();
  }

  void clearControllers() {
    widget.titleController.clear();
    widget.descriptionController.clear();
  }

  void addNewTask(BuildContext context) {
    final newTask = Task(
        id: const Uuid().v4(),
        title: widget.titleController.text.trim(),
        description: widget.descriptionController.text.trim(),
        isDone: false);
    context.read<TodoBloc>().add(AddTaskEvent(newTask));
  }

  void updateExistingTask(BuildContext context, Task task) {
    context.read<TodoBloc>().add(
          UpdateTaskEvent(
            widget.task!.copyWith(
                title: widget.titleController.text,
                description: widget.descriptionController.text),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: widget.titleController,
                autofocus: true,
                onEditingComplete: () => descriptionFocusNode.requestFocus(),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                    contentPadding: EdgeInsets.all(5)),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: widget.descriptionController,
                focusNode: descriptionFocusNode,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                  contentPadding: EdgeInsets.all(5),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    clearControllers();
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    if (widget.task == null) {
                      addNewTask(context);
                      clearControllers();
                      Navigator.pop(context);
                    } else {
                      updateExistingTask(context, widget.task!);
                      clearControllers();
                      Navigator.pop(context);
                    }
                  },
                  child: widget.task == null
                      ? const Text('Add')
                      : const Text('Save')),
            ],
          )
        ],
      ),
    );
  }
}
