import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/models/todo.dart';
import 'package:todo_app/src/widgets/date_time_picker_dialog.dart';

class AddTodoDialog extends StatefulWidget {
  AddTodoDialog({super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final TextEditingController titleFieldController = TextEditingController();

  final TextEditingController descriptionFieldController =
      TextEditingController();

  DateTime? selectedDue;

  Future<DateTime?> _showDateTimePickerDialog(BuildContext context) async {
    return showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) => DateTimePickerDialog(),
    );
  }

  Future<void> _selectDateTime() async {
    final DateTime? pickedDateTime = await _showDateTimePickerDialog(context);
    if (pickedDateTime != null) {
      setState(() {
        selectedDue = pickedDateTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a Todo'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              constraints: const BoxConstraints(maxHeight: 200),
              child: TextField(
                controller: descriptionFieldController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Enter some description',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
                autofocus: true,
                cursorColor: Colors.teal,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: _selectDateTime,
                    child: Container(
                      width: 24.0, // Smaller width
                      height: 24.0, // Smaller height
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 10),
                      child: const Icon(
                        Icons.timer,
                        size: 24.0,
                      ), // Icon with original size
                    ),
                  ),
                  if (selectedDue != null)
                    Text(
                      DateFormat('EEE, M/d/y').format(selectedDue!),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
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
            Navigator.pop(
                context,
                Todo(
                  title: titleFieldController.text,
                  description: descriptionFieldController.text,
                  due: selectedDue,
                ));
            titleFieldController.clear();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
