import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo_model.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodosInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<ToggleTodoStatus>(_onToggleTodoStatus);
  }

  // Lista de tarefas em memória para simular um banco de dados

  final List<Todo> _todos = [];

  void _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) {
    emit(const TodosLoading());
    try {
      emit(TodosLoaded(_todos));
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  void _onAddTodo(AddTodo event, Emitter<TodoState> emit) {
    // Emitimos Loading para indicar que há uma operação em progresso
    emit(const TodosLoading());

    try {
      // Adicionamos a nova tarefa à lista
      _todos.add(event.todo);

      // Emitimos o novo estado com todas as tarefas, incluindo a recém-adicionada
      emit(TodosLoaded(List.from(_todos)));
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  void _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) {
    emit(const TodosLoading());

    try {
      final todoIndex = _todos.indexWhere((todo) => todo.id == event.todo.id);
      if (todoIndex >= 0) {
        _todos[todoIndex] = event.todo;
        emit(TodosLoaded(List.from(_todos)));
      } else {
        // Se a tarefa não for encontrada, emite o estado atual
        emit(TodosLoaded(List.from(_todos)));
      }
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) {
    emit(const TodosLoading());

    try {
      _todos.removeWhere((todo) => todo.id == event.todo.id);
      emit(TodosLoaded(List.from(_todos)));
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  void _onToggleTodoStatus(ToggleTodoStatus event, Emitter<TodoState> emit) {
    emit(const TodosLoading());

    try {
      final todoIndex = _todos.indexWhere((todo) => todo.id == event.todo.id);
      if (todoIndex >= 0) {
        _todos[todoIndex] = _todos[todoIndex].copyWith(
          isCompleted: !_todos[todoIndex].isCompleted,
        );
        emit(TodosLoaded(List.from(_todos)));
      } else {
        // Se a tarefa não for encontrada, emite o estado atual
        emit(TodosLoaded(List.from(_todos)));
      }
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }
}
