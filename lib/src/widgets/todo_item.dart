import 'package:flutter/material.dart';
import 'package:todo_app/src/models/todo.dart';

class TodoItem extends StatelessWidget {
  TodoItem(
      {required this.todo,
      required this.onTodoChange,
      required this.onTodoDelete})
      : super(key: ObjectKey(todo));

  final Todo todo;
  final void Function(Todo todo) onTodoChange;
  final void Function(Todo todo) onTodoDelete;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTodoChange(todo);
      },
      leading: Checkbox(
        checkColor: Colors.greenAccent,
        activeColor: Colors.red,
        value: todo.completed,
        onChanged: (value) {
          onTodoChange(todo);
        },
      ),
      title: Row(children: <Widget>[
        Expanded(
          child: Text(todo.title, style: _getTextStyle(todo.completed)),
        ),
        IconButton(
          iconSize: 30,
          icon: Icon(
            Icons.delete,
            color: Colors.red[300],
          ),
          alignment: Alignment.centerRight,
          onPressed: () {
            onTodoDelete(todo);
          },
        ),
      ]),
    );
  }
}
