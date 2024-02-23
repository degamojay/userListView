import 'package:activity2/user_details_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage>{
  late Future<List<User>> _userList;

  @override
  void initState(){
    super.initState();
    _userList = fetchUsers();
  }

  Future<List<User>> fetchUsers() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();

    }else{
      throw Exception('Failed to load Users');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Color(0xFFB39361), 
          fontFamily: 'Times New Roman', 
          fontWeight: FontWeight.bold, 
          fontSize: 32.0 
          ),
          backgroundColor: const Color(0xFF594940),
        ),
        body: FutureBuilder<List<User>>(
          future: _userList,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError){
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                final user = snapshot.data![index];
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        user.name, 
                        style: const TextStyle(
                          color: Color(0xFFB39361),
                          ),
                        ),
                      subtitle: Text(
                        user.email, 
                        style: const TextStyle(
                          color: Color(0xFFC4BAAB),
                          ),
                        ),  
                      leading: const Icon(Icons.person_outline,
                      color: Color(
                        0xFFB39361),
                      size: 40.0,
                      ),
                      trailing: const Icon(Icons.arrow_right,
                      color: Color(
                        0xFFB39361
                      ),
                      size: 30.0,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UserDetailsPage(user: user)),
                        );
                      },
                    ),
                    const Divider(
                      color: Color(0xFFB39361),
                    ),
                  ],
                );
                },
              );
            }
          }
        ),
        backgroundColor: const Color(0xFF07213F),
      );
  }
}

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final Address address;
  final Company company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      address: Address.fromJson(json['address']),
      company: Company.fromJson(json['company']),
    );
  }
}

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
      geo: Geo.fromJson(json['geo']),
    );
  }
}

class Geo {
  final double lat;
  final double lng;

  Geo({required this.lat, required this.lng});

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']),
    );
  }
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({required this.name, required this.catchPhrase, required this.bs});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs'],
    );
  }
}
