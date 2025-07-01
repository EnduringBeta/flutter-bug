import 'package:dio/dio.dart';

import 'user.dart';

class Service {
  static const String name = 'Service';

  static const String serverUrlBase = 'http://localhost:8080';
  static const String userListUrl = '$serverUrlBase/list';

  static final _dio = Dio();

  static Future<List<User>> getUsers() async {
    final Response response = await _dio.get(userListUrl);

    if (response.statusCode != 200) {
      throw Exception('Failed to load users');
    } else {
      final List<dynamic> data = response.data;
      return data
          .map((user) => User(user['name'], user['age'], user['profession']))
          .toList();
    }
  }
}
