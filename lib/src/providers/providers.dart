import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/models/todo.dart';
import 'package:todo_app/src/services/dialog_service.dart';

final todoListProvider = StateProvider<List<Todo>>((ref) => []);

final dialogServiceProvider = Provider<DialogService>((ref) {
  return DialogService();
});
