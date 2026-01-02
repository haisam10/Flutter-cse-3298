import 'package:flutter/material.dart';

class TaskDetailScreen extends StatelessWidget {
  final Map<String, dynamic> task;
  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Details')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task['title'],
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(task['description'] ?? 'No description'),
            const SizedBox(height: 20),
            Text('Category: ${task['category']}'),
            const SizedBox(height: 10),
            Text(
              'Due: ${task['date'].day}/${task['date'].month}/${task['date'].year}',
            ),
          ],
        ),
      ),
    );
  }
}
