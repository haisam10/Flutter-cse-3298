class Task {
  String title;
  String category;
  DateTime dueDate;
  bool isCompleted;

  Task({
    required this.title,
    required this.category,
    required this.dueDate,
    this.isCompleted = false,
  });
}
