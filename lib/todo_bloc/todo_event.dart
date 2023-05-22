part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class GetAllTaskEvent extends TodoEvent {}

class AddTaskEvent extends TodoEvent {
  final Task task;
  const AddTaskEvent(this.task) : super();

  @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends TodoEvent {
  final Task task;
  const UpdateTaskEvent(this.task) : super();

  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends TodoEvent {
  final Task task;
  const DeleteTaskEvent(this.task) : super();

  @override
  List<Object> get props => [task];
}
