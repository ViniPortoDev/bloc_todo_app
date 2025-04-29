import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import '../widgets/todo_item.dart';
import 'add_todo_screen.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodosInitial) {
            // Carrega a lista de tarefas quando o aplicativo iniciar
            context.read<TodoBloc>().add(const LoadTodos());
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodosLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodosLoaded) {
            return state.todos.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma tarefa adicionada',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      return TodoItem(todo: state.todos[index]);
                    },
                  );
          } else if (state is TodosError) {
            return Center(
              child: Text(
                'Erro: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTodoScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}