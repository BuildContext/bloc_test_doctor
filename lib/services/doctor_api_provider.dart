import 'dart:convert';
import 'package:bloc_test_doctor/models/doctor.dart';
import 'package:http/http.dart' as http;

class DoctorProvider {
  final String baseUrl =
      'https://5fe21e077a94870017682132.mockapi.io/api/testtask/doctors';

  Future<List<Doctor>> getDoctors({int? start, int? count}) async {
    final response = await _getResponse(baseUrl);

    if (response.statusCode == 200) {
      List<dynamic> doctorJson = json.decode(response.body);

      //for simulate pagination
      if (count != null && start != null) {
        int end = start + count;
        if (end >= doctorJson.length - 1) {
          //load end of doctorJson list
          if ((doctorJson.length) - start > 0) {
            end = doctorJson.length;
          } else {
            return [];
          }
        }
        doctorJson = doctorJson.sublist(start, end);
      }
      final List<dynamic> checkedDoctorJson = await _checkImages(doctorJson);
      return checkedDoctorJson.map((json) => Doctor.fromJson(json)).toList();
    } else {
      //print(response.statusCode);
      throw Exception('Error fetching doctor\'s list');
    }
  }

  Future<List> _checkImages(List<dynamic> doctorJson) async {
    Iterable<Future> mapJson = doctorJson.map((json) async {
      bool isValidImage = await isValidUrl(json['avatar']);

      if (!isValidImage) {
        json['avatar'] = '';
      }
      return json;
    });
    return await Future.wait(mapJson).then((value) => value.toList());
  }

  Future<dynamic> _getResponse(String url) async {
    final uri = _getUriFromUrl(url);
    // check head url before featch body url
    if (await isValidUrl(url)) {
      return await http.get(uri);
    } else {
      return http.Response('', 400);
    }
  }

  Future<bool> isValidUrl(String url) async {
    final uri = _getUriFromUrl(url);
    try {
      final response = await http.head(uri);
      return response.statusCode == 200;
    } catch (_) {
      //print('url $url is not valid');
      return false;
    }
  }

  Uri _getUriFromUrl(String url) {
    final String scheme = Uri.parse(url).scheme;
    final String authority = Uri.parse(url).authority;
    final String path = Uri.parse(url).path;

    switch (scheme) {
      case 'http':
        return Uri.http(authority, path);
      case 'https':
        return Uri.https(authority, path);
      default:
        throw Exception('Error parse url scheme');
    }
  }
}
