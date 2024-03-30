import 'package:flutter/material.dart';
import 'package:todo_app/src/models/todo.dart';
import 'package:todo_app/src/widgets/todo_list.dart';
import 'package:todo_app/src/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  // void initState() {
  //   super.initState();
  //   dialogService = DialogService(context);
  // }

  void _handleTodoChange(Todo todo) {
    // setState(() {
    //   todo.completed = !todo.completed;
    // });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Todo> todos = ref.watch(todoListProvider);
    final dialogService = ref.watch(dialogServiceProvider);
    double statusBarHeight = MediaQuery.of(context).padding.top;

    void handleAddTodo() async {
      final Todo? newTodo = await dialogService.showAddTodoDialog(context);
      if (newTodo != null) {
        ref.read(todoListProvider.notifier).state = [...todos, newTodo];
      }
    }

    void handleTodoDelete(Todo todo) {
      ref.read(todoListProvider.notifier).state = ref
          .read(todoListProvider.notifier)
          .state
          .where((item) => item.title != todo.title)
          .toList();
    }

    void handleTodoChange(Todo todo) {
      ref.read(todoListProvider.notifier).state =
          ref.read(todoListProvider.notifier).state.map((currentTodo) {
        if (currentTodo.id == todo.id)
          currentTodo.completed = !currentTodo.completed;
        return currentTodo;
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu)),
        ),
        title: const Text('Your Todos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.teal,
        child: ListView(
          // padding: EdgeInsets.only(top: 100),
          children: [
            SizedBox(
              height: statusBarHeight,
              child: const DrawerHeader(
                child: Center(
                  child: Text(
                    '',
                  ),
                ),
              ),
            ),
            const ListTile(
              title: Text(
                'First',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const ListTile(
              title: Text(
                'Second',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            )
          ],
        ),
      ),
      body: TodoList(
        onTodoChange: handleTodoChange,
        onTodoDelete: handleTodoDelete,
      ),
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(
        onPressed: handleAddTodo,
        tooltip: 'Add Todo',
        backgroundColor: Colors.white,
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0), // You can adjust the radius value as needed
          ),
        ),
        child: const Icon(Icons.add, color: Colors.teal),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, // Centering the FAB
    );
  }
}
