import 'package:todo_app_provider/core/service_locator.dart';
import 'package:todo_app_provider/models/sync.dart';
import 'package:todo_app_provider/models/user/user.dart';
import 'package:todo_app_provider/services/connectivity_service.dart';
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
    bool connection = await locator.get<ConnectivityService>().check();
    if(connection) {
      return _loginNet(login, password);
    }else {
      return _loginLocal(login, password);
    }
  }

  @override
  Future<User?> authUser(User user) async {
    bool connection = await locator.get<ConnectivityService>().check();
    if(connection) {
      return _authNet(user);
    }else {
      return _authLocal(user);
    }
  }



  // Network
  Future<User?> _loginNet(String login, String password) async{
    List response = await client.get(api: Api.users) as List;
    for(var user in response) {
      User jsonUser =  User.fromJson(user);
      if(jsonUser.name == login && jsonUser.password == password) {
        return jsonUser;
      }
    }
    return null;
  }

  Future<User?> _authNet(User user) async {
    final jsonUser = await client.post(api: Api.users, data: {
      "createdAt": user.createdAt,
      "name": user.name,
      "password": user.password,
      "sync" : Sync.right.ts(),
    });
    return User.fromJson(jsonUser as Map<String, Object?>);
  }
  
  
  
  
  // Local
  
  Future<User?> _loginLocal(String login, String password) async{
    List response = await client.get(api: Api.users) as List;
    for(var user in response) {
      User jsonUser =  User.fromJson(user);
      if(jsonUser.name == login && jsonUser.password == password) {
        return jsonUser;
      }
    }
    return null;
  }


  Future<User?> _authLocal(User user) async {
    final jsonUser = await client.post(api: Api.users, data: {
      "createdAt": user.createdAt,
      "name": user.name,
      "password": user.password,
      "sync" : Sync.create.ts(),
    });
    return User.fromJson(jsonUser as Map<String, Object?>);
  }

}