import 'package:flutter/material.dart';
import 'package:todo_app/src/models/todo.dart';
import 'package:todo_app/src/widgets/add_todo_dialog.dart';
import 'package:todo_app/src/widgets/date_time_picker_dialog.dart';

class DialogService {
  Future<Todo?> showAddTodoDialog(BuildContext context) async {
    return showDialog<Todo>(
      context: context,
      builder: (BuildContext context) => const AddTodoDialog(),
    );
  }

  Future<DateTime?> showDateTimePickerDialog(BuildContext context) async {
    return showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) => const DateTimePickerDialog(),
    );
  }
}
