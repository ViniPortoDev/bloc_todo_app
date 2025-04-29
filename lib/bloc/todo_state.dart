import 'package:equatable/equatable.dart';
import '../models/todo_model.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodosInitial extends TodoState {
  const TodosInitial();
}

class TodosLoading extends TodoState {
  const TodosLoading();
}

class TodosLoaded extends TodoState {
  final List<Todo> todos;

  const TodosLoaded(this.todos);

  @override
  List<Object> get props => [todos];
}

class TodosError extends TodoState {
  final String message;

  const TodosError(this.message);

  @override
  List<Object> get props => [message];
}