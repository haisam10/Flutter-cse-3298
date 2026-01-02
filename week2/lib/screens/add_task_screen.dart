import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddTask;
  const AddTaskScreen({super.key, required this.onAddTask});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  String category = 'Work';
  DateTime dueDate = DateTime.now();

  void submit() {
    if (_formKey.currentState!.validate()) {
      widget.onAddTask({
        'title': titleCtrl.text,
        'description': descCtrl.text,
        'category': category,
        'date': dueDate,
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Task added successfully')));

      titleCtrl.clear();
      descCtrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v == null || v.length < 3 ? 'Min 3 characters' : null,
            ),
            const SizedBox(height: 15),

            TextFormField(
              controller: descCtrl,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 15),

            DropdownButtonFormField(
              value: category,
              items: [
                'Work',
                'Study',
                'Personal',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => category = v!),
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            Row(
              children: [
                const Text('Due Date:'),
                TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2026),
                      initialDate: dueDate,
                    );
                    if (picked != null) {
                      setState(() => dueDate = picked);
                    }
                  },
                  child: Text(
                    '${dueDate.day}/${dueDate.month}/${dueDate.year}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            ElevatedButton(onPressed: submit, child: const Text('Add Task')),
          ],
        ),
      ),
    );
  }
}
