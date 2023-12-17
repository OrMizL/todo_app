class Todo {
  String title;
  String description;
  bool completed;
  DateTime? due;
  DateTime? reminder;

  Todo({
    required this.title,
    this.description = '',
    this.completed = false,
    this.due,
    this.reminder,
  });
}
