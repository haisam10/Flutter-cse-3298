import 'package:flutter/material.dart';
import 'task_detail_screen.dart';

class TasksScreen extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;
  const TasksScreen({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(child: Text('No tasks added yet'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          child: ListTile(
            title: Text(task['title']),
            subtitle: Text(task['category']),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TaskDetailScreen(task: task)),
              );
            },
          ),
        );
      },
    );
  }
}
