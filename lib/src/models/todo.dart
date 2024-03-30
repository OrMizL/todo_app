import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Todo {
  String id;
  String title;
  String description;
  bool completed;
  DateTime? due;
  DateTime? reminder;

  Todo({
    String? id,
    required this.title,
    this.description = '',
    this.completed = false,
    this.due,
    this.reminder,
  }) : id = id ?? const Uuid().v4();
}
