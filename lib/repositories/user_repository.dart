import 'dart:convert';
import 'package:todo_app_provider/models/user/user.dart';
import 'package:todo_app_provider/services/network_service.dart';

abstract class UserRepository {
  const UserRepository();

  Future<User?> loginUser(String login, String password);
  Future<User?> authUser(User user);
}


















class UserRepositoryImpl extends UserRepository {
  final Network client;
  const UserRepositoryImpl({required this.client});

  @override
  Future<User?> loginUser(String login, String password) async{
    List response = await client.get(api: Api.users) as List;
    for(var user in response) {
      User jsonUser =  User.fromJson(user);
      if(jsonUser.name == login && jsonUser.password == password) {
        return jsonUser;
      }
    }
    return null;
  }

  @override
  Future<User?> authUser(User user) async {
    final jsonUser = await client.post(api: Api.users, data: {
      "createdAt": user.createdAt,
      "name": user.name,
      "password": user.password,
    });
    return User.fromJson(jsonUser as Map<String, Object?>);
  }


}