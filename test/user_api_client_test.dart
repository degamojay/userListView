import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:activity2/api/user_api_client.dart';
import 'package:activity2/models/user.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late UserApiClient userApiClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    userApiClient = UserApiClient(client: mockHttpClient);
  });
  test(
    // arrange
    "Given UserApiClient is instantiated, when fetchUsers is called and return is 200, then a list of User objects should be returned.",
    () async {
      final List<Map<String, dynamic>> mockUsersJson = [
        {
          "id": 1,
          "name": "Leanne Graham",
          "username": "Bret",
          "email": "Sincere@april.biz",
          "address": {
            "street": "Kulas Light",
            "suite": "Apt. 556",
            "city": "Gwenborough",
            "zipcode": "92998-3874",
            "geo": {"lat": "-37.3159", "lng": "81.1496"}
          },
          "phone": "1-770-736-8031 x56442",
          "website": "hildegard.org",
          "company": {
            "name": "Romaguera-Crona",
            "catchPhrase": "Multi-layered client-server neural-net",
            "bs": "harness real-time e-markets"
          }
        },
      ];

      when(() => mockHttpClient
              .get(Uri.parse('https://jsonplaceholder.typicode.com/users')))
          .thenAnswer(
              (_) async => http.Response(jsonEncode(mockUsersJson), 200));

      // act
      final users = await userApiClient.fetchUsers();

      // assert
      expect(users, isA<List<User>>());
      verify(() => mockHttpClient.get(
          Uri.parse('https://jsonplaceholder.typicode.com/users'))).called(1);
    },
  );

  test(
    "Given UserApiClient is instantiated, when fetchUsers is called and return is 404, then an exception should be thrown.",
    () async {
      // arrange
      when(() => mockHttpClient
              .get(Uri.parse('https://jsonplaceholder.typicode.com/users')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // act & assert
      expect(userApiClient.fetchUsers(), throwsA(isA<Exception>()));
      verify(() => mockHttpClient.get(
          Uri.parse('https://jsonplaceholder.typicode.com/users'))).called(1);
    },
  );
}
