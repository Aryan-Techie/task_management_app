// Task is the data model for this app
// it maps directly to what the JSONPlaceholder API returns

class Task {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  Task({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  // converts raw JSON from the API into a Task object
  // e.g. {"id": 1, "title": "buy milk", ...} → Task(...)
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  // not really used right now but good to have if I ever need to send data back
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'completed': completed,
    };
  }

  // copyWith lets me create a modified copy without changing the original
  // used when toggling complete or editing the title
  // the ?? means "use the new value if provided, otherwise keep the old one"
  Task copyWith({
    int? id,
    int? userId,
    String? title,
    bool? completed,
  }) {
    return Task(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}