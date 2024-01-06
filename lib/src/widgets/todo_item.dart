import 'package:flutter/material.dart';
import 'package:todo_app/src/models/todo.dart';
import 'package:intl/intl.dart';

class TodoItem extends StatelessWidget {
  TodoItem(
      {required this.todo,
      required this.onTodoChange,
      required this.onTodoDelete})
      : super(key: ObjectKey(todo));

  final Todo todo;
  final void Function(Todo todo) onTodoChange;
  final void Function(Todo todo) onTodoDelete;

  TextStyle? _getTextStyle(bool checked, bool isDescription) {
    TextStyle styleToBeApplied = TextStyle(
      fontSize: isDescription ? 16.0 : 20.0,
      color: isDescription ? Colors.black87 : Colors.black,
    );

    if (checked) {
      styleToBeApplied = styleToBeApplied.copyWith(
        color: Colors.black54,
        decoration: TextDecoration.lineThrough,
      );
    }

    return styleToBeApplied;
  }

  String _getTimeUntilRemaining(DateTime? reminderDateTime) {
    Duration difference = reminderDateTime!.difference(DateTime.now());
    List<String> stringParts = [];

    if (difference.inDays > 0) stringParts.add('${difference.inDays}d');

    if ((difference.inHours % 24) > 0) {
      stringParts.add('${difference.inHours % 24}h');
    }

    if ((difference.inMinutes % 60) > 0) {
      stringParts.add('${difference.inMinutes % 60}m');
    }

    return stringParts.join(', ');
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
      title: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: _getTextStyle(todo.completed, false),
                ),
                if (todo.description != '')
                  Text(
                    todo.description,
                    style: _getTextStyle(todo.completed, true),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(
                  height: 10,
                ),
                if (todo.due != null || todo.reminder != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (todo.due != null)
                        Column(
                          children: [
                            Icon(
                              Icons.today,
                              color: Colors.deepPurple[500],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              DateFormat('M/d/yy').format(todo.due!),
                              style: TextStyle(
                                  fontSize: 14, color: Colors.deepPurple[500]),
                            ),
                            Text(
                              DateFormat('HH:mm').format(todo.due!),
                              style: TextStyle(
                                  fontSize: 14, color: Colors.deepPurple[500]),
                            ),
                          ],
                        ),
                      if (todo.reminder != null)
                        Column(
                          children: [
                            Icon(
                              Icons.notifications,
                              color: Colors.deepPurple[500],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Reminded in',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.deepPurple[500],
                              ),
                            ),
                            Text(
                              _getTimeUntilRemaining(todo.reminder),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.deepPurple[500],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
      trailing: IconButton(
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
    );
  }
}
