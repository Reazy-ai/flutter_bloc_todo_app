import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todo_app/data_model/task.dart';
import 'package:flutter_todo_app/src/services/todo_service.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({required TodoService service}) : super(TodoEmpty()) {
    on<AddTaskEvent>((event, emit) async {
      emit(TodoLoading());
      await service.addTodo(event.task);
      final allTasks = service.getAllTasks();
      emit(TasksRetrieved(allTasks));
    });

    on<GetAllTaskEvent>((event, emit) {
      emit(TodoLoading());
      final allTasks = service.getAllTasks();
      emit(TasksRetrieved(allTasks));
    });

    on<UpdateTaskEvent>((event, emit) async {
      emit(TodoLoading());
      await service.updateTask(event.task);
      add(GetAllTaskEvent());
    });

    on<DeleteTaskEvent>((event, emit) async {
      emit(TodoLoading());
      await service.deleteTask(event.task);
      add(GetAllTaskEvent());
    });
  }
}
