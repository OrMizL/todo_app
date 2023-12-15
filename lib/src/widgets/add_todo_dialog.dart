import 'package:flutter/material.dart';
import 'package:todo_app/src/models/todo.dart';

class AddTodoDialog extends StatelessWidget {
  AddTodoDialog({super.key});

  final TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a Todo'),
      content: TextField(
        controller: textFieldController,
        decoration: const InputDecoration(
          hintText: 'Type your todo',
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
        ),
        autofocus: true,
        cursorColor: Colors.teal,
      ),
      actions: <Widget>[
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            // Navigator.of(context).pop();
            Navigator.pop(context,
                Todo(name: textFieldController.text, completed: false));
            textFieldController.clear();
            // _addTodoItem(textFieldController.text);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
