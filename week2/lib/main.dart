import 'package:flutter/material.dart';
import 'screens/tasks_screen.dart';
import 'screens/add_task_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final List<Map<String, dynamic>> tasks = [];

  void addTask(Map<String, dynamic> task) {
    setState(() {
      tasks.add(task);
      index = 0;
    });
  }

  late final screens = [
    TasksScreen(tasks: tasks),
    AddTaskScreen(onAddTask: addTask),
    ProfileScreen(tasks: tasks),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(['Tasks', 'Add Task', 'Profile'][index])),
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Task'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
