import 'package:flutter/material.dart';
import 'package:activity2/models/user.dart';
import 'package:activity2/models/user_details_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserListPage(),
    );
  }
}

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<List<User>> _userList;

  @override
  void initState() {
    super.initState();
    _userList = fetchUsers();
  }

  Future<List<User>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.135:3001/fakeUsers'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<User>>(
          future: _userList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final user = snapshot.data![index];
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          user.name,
                        ),
                        subtitle: Text(
                          user.email,
                        ),
                        leading: const Icon(Icons.person_outline),
                        trailing: const Icon(Icons.arrow_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UserDetailsPage(user: user)),
                          );
                        },
                      ),
                      const Divider(),
                    ],
                  );
                },
              );
            }
          }),
    );
  }
}