import 'dart:convert';

import 'package:activity2/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Todos extends StatefulWidget {
  const Todos({super.key});

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {

  late Future<List<Todo>> todos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todos = getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos'),),
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(10), 
          child: FutureBuilder<List<Todo>>(
          future: todos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final todo = snapshot.data![index];
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          todo.title,
                        ),
                       
                        trailing: Checkbox(value: todo.finished, onChanged: (value){}),
                        onTap: () {},
                      ),
                      const Divider(),
                    ],
                  );
                },
              );
            } else  if(snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
              
            } else {
              return const Center(child: CircularProgressIndicator(),);
            }
          }),)),
    );
  }

  Future<List<Todo>> getUsers() async {
    final response =
        // await http.get(Uri.parse('http://192.168.1.135:3001/fakeUsers'));
        await http.get(Uri.parse('http://10.0.2.2:3001/todos'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Users');
    }
  }
}