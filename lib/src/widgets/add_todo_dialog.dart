import 'package:flutter/material.dart';
import 'package:todo_app/src/models/todo.dart';

class AddTodoDialog extends StatelessWidget {
  AddTodoDialog({super.key});

  final TextEditingController titleFieldController = TextEditingController();
  final TextEditingController descriptionFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a Todo'),
      content: Column(
        children: [
          TextField(
            controller: titleFieldController,
            decoration: const InputDecoration(
              hintText: 'Type your todo',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
              ),
            ),
            autofocus: true,
            cursorColor: Colors.teal,
          ),
          TextField(
            controller: titleFieldController,
            decoration: const InputDecoration(
              hintText: 'Type your todo',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
              ),
            ),
            autofocus: true,
            cursorColor: Colors.teal,
          ),
        ],
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
            Navigator.pop(context, Todo(title: titleFieldController.text));
            titleFieldController.clear();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
