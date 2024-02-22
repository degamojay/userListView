import 'package:flutter/material.dart';
import 'user.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;
  const UserDetailsPage({Key? key, required this.user}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        centerTitle: true,
         titleTextStyle: const TextStyle(
          color: Color(0xFFB39361), 
          fontFamily: 'Times New Roman', 
          fontWeight: FontWeight.bold, 
          fontSize: 30.0 
          ),
          backgroundColor: const Color(0xFF594940),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserDetail('Name', user.name),
            _buildUserDetail('Username', user.username),
            _buildUserDetail('Email', user.email),
            _buildUserDetail('Phone', user.phone),
            _buildUserDetail('Website', user.website),
            const SizedBox(height: 20),
            _buildAddressDetails(user.address),
            const SizedBox(height: 20),
            _buildCompanyDetails(user.company),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF07213F),
    );
  }
}

Widget _buildUserDetail(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$label:',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFFB39361),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFFC4BAAB),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _buildAddressDetails(Address address) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Address:',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFFB39361),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        '${address.street}, ${address.suite}, ${address.city}',
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFFB39361),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        'Zip: ${address.zipcode}',
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFFC4BAAB),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        'Lat: ${address.geo.lat}',
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFFC4BAAB),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        'Lng: ${address.geo.lng}',
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFFC4BAAB),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _buildCompanyDetails(Company company) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Company:',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFFB39361),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        company.name,
        style: const TextStyle(
          fontSize: 18,
          color: Color(0xFFB39361),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        '"${company.catchPhrase}"',
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFFC4BAAB),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        ' bs: ${company.bs}',
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFFC4BAAB),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

