// add_task_screen.dart - Form with validation
import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedCategory = 'work';
  String _selectedPriority = 'medium';
  DateTime _dueDate = DateTime.now().add(const Duration(days: 1));

  final List<String> categories = ['work', 'personal', 'study', 'shopping'];
  final List<String> priorities = ['low', 'medium', 'high'];

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025, 12, 31),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, process the data
      final Map<String, dynamic> newTask = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'category': _selectedCategory,
        'priority': _selectedPriority,
        'dueDate': _dueDate,
        'createdAt': DateTime.now(),
      };

      // Show success message and navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task "${_titleController.text}" added successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, newTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add New Task',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),

            // Task Title Field
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a task title';
                }
                if (value.length < 3) {
                  return 'Title must be at least 3 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Description Field
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Category Dropdown
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category.toUpperCase()),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),
            const SizedBox(height: 16),

            // Priority Dropdown
            DropdownButtonFormField<String>(
              value: _selectedPriority,
              decoration: const InputDecoration(
                labelText: 'Priority',
                prefixIcon: Icon(Icons.priority_high),
                border: OutlineInputBorder(),
              ),
              items: priorities.map((String priority) {
                return DropdownMenuItem<String>(
                  value: priority,
                  child: Text(priority.toUpperCase()),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPriority = newValue!;
                });
              },
            ),
            const SizedBox(height: 16),

            // Due Date Picker
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.grey),
                const SizedBox(width: 10),
                const Text('Due Date:'),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: _selectDate,
                  child: Text(
                    '${_dueDate.day}/${_dueDate.month}/${_dueDate.year}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Submit Button
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Add Task',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
