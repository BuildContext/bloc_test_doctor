import 'dart:convert';

import 'package:bloc_test_doctor/models/user.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  Future<List<User>> getUser() async {
    final response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', '/users'));

    if (response.statusCode == 200) {
      final List<dynamic> userJson = json.decode(response.body);
      return userJson.map((json) => User.fromJson(json)).toList();
    } else {
      print(response.statusCode);
      throw Exception('Error fetching userS');
    }
  }
}
