// main.dart - Week 2: Multi-screen Task Manager
import 'package:flutter/material.dart';
import 'screens/add_task_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/task_detail_screen.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advanced Task Manager',
      theme: ThemeData(primarySwatch: Colors.purple, fontFamily: 'Roboto'),
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
  int _selectedIndex = 0;

  // Screens for bottom navigation
  final List<Widget> _screens = [
    TasksScreen(),
    AddTaskScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'My Tasks'
              : _selectedIndex == 1
              ? 'Add Task'
              : 'Profile',
        ),
        actions: [
          _selectedIndex == 0
              ? IconButton(icon: const Icon(Icons.search), onPressed: () {})
              : Container(),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }
}

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TaskCard(
          title: 'Complete Week 2 Lab',
          description: 'Navigation & Forms implementation',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TaskDetailScreen()),
            );
          },
        ),
        // More task cards...
      ],
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
