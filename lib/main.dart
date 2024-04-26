import 'package:flutter/material.dart';
import 'package:todo_app/src/screens/main_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(
    child: TodoApp(),
  ));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The TODO list of the future',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF6200EE), // Primary color
          onPrimary: Colors
              .white, // Ideally, a color that contrasts well with the primary color
          secondary: Colors.yellow, // Secondary color
          onSecondary: Colors.black, // Contrasting color for secondary
          error: Colors.red, // Typically red
          onError: Colors.white, // Text color on error backgrounds
          background: Colors.black, // Background color for screens/widgets
          onBackground: Colors.white, // Text color to use on background color
          surface: Colors.black, // Background color for cards, menus
          onSurface: Colors.white, // Text color to use on surface colors
        ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            fontSize: 16.0,
          ),
          bodyMedium: TextStyle(
            fontSize: 20.0,
          ),
          bodyLarge: TextStyle(
            fontSize: 24.0,
          ),
          headlineSmall: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}
