import 'package:flutter/material.dart';
import 'package:todo_app/src/models/todo.dart';
import 'package:todo_app/src/widgets/add_todo_dialog.dart';

class DialogService {
  final BuildContext context;

  DialogService(this.context);

  Future<Todo?> showAddTodoDialog() async {
    return showDialog<Todo>(
      context: context,
      builder: (BuildContext context) => AddTodoDialog(),
    );
  }
}
