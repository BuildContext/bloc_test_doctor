import 'package:bloc_test_doctor/models/user.dart';
import 'package:bloc_test_doctor/services/user_api_provider.dart';

class UsersRepository {
  UserProvider _usersProvider = UserProvider();
  Future<List<User>> getAllUsers() => _usersProvider.getUser();
}
