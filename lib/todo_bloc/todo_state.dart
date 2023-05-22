part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoEmpty extends TodoState {}

class TodoLoading extends TodoState {}

class TasksRetrieved extends TodoState {
  final List<Task> tasks;

  const TasksRetrieved(this.tasks);

  @override
  List<Object> get props => [];
}
