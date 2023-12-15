import 'package:flutter/material.dart';
import 'package:todo_app/src/models/todo.dart';
import 'package:todo_app/src/services/dialog_service.dart';
import 'package:todo_app/src/widgets/todo_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Todo> _todos = <Todo>[];
  late DialogService dialogService;

  @override
  void initState() {
    super.initState();
    dialogService = DialogService(context);
  }

  void _handleAddTodo() async {
    final Todo? newTodo = await dialogService.showAddTodoDialog();
    if (newTodo != null) {
      setState(() {
        _todos.add(newTodo);
      });
    }
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.completed = !todo.completed;
    });
  }

  void _handleTodoDelete(Todo todo) {
    setState(() {
      _todos.removeWhere((element) => element.title == todo.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

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
        todos: _todos,
        onTodoChange: _handleTodoChange,
        onTodoDelete: _handleTodoDelete,
      ),
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(
        onPressed: _handleAddTodo,
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
