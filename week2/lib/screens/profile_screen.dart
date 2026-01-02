import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final List<Map<String, dynamic>> tasks;
  const ProfileScreen({super.key, required this.tasks});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notifications = true;
  String name = "Md Haisam";

  void editProfile() {
    final controller = TextEditingController(text: name);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Profile'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => name = controller.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
        const SizedBox(height: 10),
        Center(
          child: Text(name, style: Theme.of(context).textTheme.titleLarge),
        ),
        TextButton(onPressed: editProfile, child: const Text('Edit Profile')),
        const Divider(),

        ListTile(
          title: const Text('Total Tasks'),
          trailing: Text(widget.tasks.length.toString()),
        ),

        SwitchListTile(
          title: const Text('Notifications'),
          value: notifications,
          onChanged: (v) => setState(() => notifications = v),
        ),
      ],
    );
  }
}
