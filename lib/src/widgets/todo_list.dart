import 'package:flutter/material.dart';
import 'package:todo_app/src/models/todo.dart';
import 'package:todo_app/src/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  TodoList(
      {required this.todos,
      required this.onTodoChange,
      required this.onTodoDelete})
      : super(key: ObjectKey(todos));

  final List<Todo> todos;
  final void Function(Todo todo) onTodoChange;
  final void Function(Todo todo) onTodoDelete;

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        children: todos.map((Todo todo) {
          return TodoItem(
              todo: todo,
              onTodoChange: onTodoChange,
              onTodoDelete: onTodoDelete);
        }).toList());
  }
}
