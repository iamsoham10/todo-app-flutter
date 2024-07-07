import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/screens/home_screen.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

//#FFF463

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskProvider(),
        ),
      ],
      child: MaterialApp(
        routes: {
          "/": (context) => new HomePage(
                isUpdate: true,
              ),
        },
      ),
    );
  }
}
