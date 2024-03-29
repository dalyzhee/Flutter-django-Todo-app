class Todo {
  final String title;
  final String description;
  final bool completed;

  Todo({
    required this.title,
    required this.description,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    print("Raw JSON: $json");
    return Todo(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      completed: json['completed'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'email': completed,
    };
  }
}
