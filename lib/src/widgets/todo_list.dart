import 'package:flutter/material.dart';
import 'package:todo_app/src/models/todo.dart';
import 'package:todo_app/src/widgets/todo_item.dart';
import 'package:todo_app/src/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoList extends ConsumerWidget {
  const TodoList(
      {super.key, required this.onTodoChange, required this.onTodoDelete});

  final void Function(Todo todo) onTodoChange;
  final void Function(Todo todo) onTodoDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoListProvider);

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      children: todos.map((Todo todo) {
        return Column(
          children: [
            TodoItem(
              todo: todo,
              onTodoChange: onTodoChange,
              onTodoDelete: onTodoDelete,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      }).toList(),
    );
  }
}
