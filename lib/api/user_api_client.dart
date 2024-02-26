import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:activity2/models/user.dart';

class UserApiClient {
  final http.Client client;

  UserApiClient({required this.client});

  Future<List<User>> fetchUsers() async {
    final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    //final response = await client.get(Uri.parse('http://192.168.1.135:3001/fakeUsers'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Users');
    }
  }
}
