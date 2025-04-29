import 'package:equatable/equatable.dart';
import '../models/todo_model.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodoEvent {
  const LoadTodos();
}

class AddTodo extends TodoEvent {
  final Todo todo;

  const AddTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class UpdateTodo extends TodoEvent {
  final Todo todo;

  const UpdateTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class DeleteTodo extends TodoEvent {
  final Todo todo;

  const DeleteTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class ToggleTodoStatus extends TodoEvent {
  final Todo todo;

  const ToggleTodoStatus(this.todo);

  @override
  List<Object> get props => [todo];
}