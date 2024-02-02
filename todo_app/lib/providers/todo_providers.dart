import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todos.dart';
import 'package:http/http.dart' as http;

final tododProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  Future<List<Todo>> fetchTodo() async {
    final response =
        await http.get(Uri.parse("http://127.0.0.1:8000/api/todos/"));
    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body);
      final List<Todo> todos =
          dataList.map((json) => Todo.fromJson(json)).toList();
      return todos;
    } else {
      throw Exception("Failed tp load todos");
    }
  }
}
