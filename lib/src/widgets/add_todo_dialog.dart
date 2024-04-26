import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/models/todo.dart';
import 'package:todo_app/src/providers/providers.dart';

class AddTodoDialog extends ConsumerStatefulWidget {
  const AddTodoDialog({super.key});

  @override
  ConsumerState<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends ConsumerState<AddTodoDialog> {
  final TextEditingController titleFieldController = TextEditingController();

  final TextEditingController descriptionFieldController =
      TextEditingController();

  DateTime? selectedDue;
  bool notificationsOn = false;
  int? selectedReminderValue;
  String? selectedReminderUnit;

  List<DropdownMenuItem<int>> reminderValueItems = List.generate(
    60,
    (index) => DropdownMenuItem(
      value: index + 1,
      child: Text('${index + 1}'),
    ),
  );

  List<DropdownMenuItem<String>> reminderUnitItems = [
    const DropdownMenuItem(value: 'Minutes', child: Text('Minutes')),
    const DropdownMenuItem(value: 'Hours', child: Text('Hours')),
    const DropdownMenuItem(value: 'Days', child: Text('Days')),
  ];

  DateTime? _getReminderDateTime() {
    switch (selectedReminderUnit) {
      case 'Minutes':
        return selectedDue!.subtract(Duration(minutes: selectedReminderValue!));
      case 'Hours':
        return selectedDue!.subtract(Duration(hours: selectedReminderValue!));
      case 'Days':
        return selectedDue!.subtract(Duration(days: selectedReminderValue!));
      default:
        return null;
    }
  }

  void _toggleNotifications() {
    if (selectedDue != null) {
      selectedReminderValue = notificationsOn ? null : 1;
      selectedReminderUnit = notificationsOn ? null : 'Minutes';
      setState(() {
        notificationsOn = !notificationsOn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dialogService = ref.watch(dialogServiceProvider);

    Future<void> selectDateTime() async {
      final DateTime? pickedDateTime =
          await dialogService.showDateTimePickerDialog(context);
      if (pickedDateTime != null) {
        setState(() {
          selectedDue = pickedDateTime;
        });
      }
    }

    return AlertDialog(
      title: Text(
        'Add a Todo',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleFieldController,
              decoration: InputDecoration(
                hintText: 'Type your todo',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              autofocus: true,
              cursorColor: Theme.of(context).colorScheme.primary,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              constraints: const BoxConstraints(maxHeight: 200),
              child: TextField(
                controller: descriptionFieldController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Enter some description',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                autofocus: true,
                cursorColor: Theme.of(context).colorScheme.primary,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: selectDateTime,
                    child: Container(
                      width: 24.0,
                      height: 24.0,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.today,
                        size: 24.0,
                        color: selectedDue != null ? Colors.lime : Colors.black,
                      ),
                    ),
                  ),
                  if (selectedDue != null)
                    Text(
                      DateFormat('EEE, M/d/y - HH:mm').format(selectedDue!),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: _toggleNotifications,
                    child: Container(
                      width: 24.0,
                      height: 24.0,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.notifications,
                        size: 24.0,
                        color: notificationsOn ? Colors.lime : Colors.black,
                      ),
                    ),
                  ),
                  if (notificationsOn)
                    Row(
                      children: <Widget>[
                        DropdownButton<int>(
                          value: selectedReminderValue ?? 1,
                          items: reminderValueItems,
                          onChanged: (value) {
                            setState(() {
                              selectedReminderValue = value!;
                            });
                          },
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        DropdownButton<String>(
                          value: selectedReminderUnit ?? 'Minutes',
                          items: reminderUnitItems,
                          onChanged: (value) {
                            setState(() {
                              selectedReminderUnit = value!;
                            });
                          },
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          ' Before',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
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
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () {
            Navigator.pop(
              context,
              Todo(
                title: titleFieldController.text,
                description: descriptionFieldController.text,
                due: selectedDue,
                reminder: notificationsOn ? _getReminderDateTime() : null,
              ),
            );
            titleFieldController.clear();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
