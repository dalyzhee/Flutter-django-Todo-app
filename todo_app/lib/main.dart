import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/todos.dart';

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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.blue,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Todo"),
          ),
          body: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Todo>> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Todo>>(
        future: futurePost,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final todo = snapshot.data![index];
                return ListTile(
                  title: Text('Todo: ${todo.title}'),
                  subtitle: Text('Description: ${todo.description}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
