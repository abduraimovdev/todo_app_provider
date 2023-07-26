import 'package:todo_app_provider/core/service_locator.dart';
import 'package:todo_app_provider/models/sync.dart';
import 'package:todo_app_provider/models/todo/todo.dart';
import 'package:todo_app_provider/services/connectivity_service.dart';
import 'package:todo_app_provider/services/db_service.dart';
import 'package:todo_app_provider/services/network_service.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();

  Future<Todo> getTodo(String id);

  Future<bool> deleteTodo(String id);

  Future<Todo> updateTodo(String id, Todo todo);

  Future<void> createTodo(Todo todo);

  Future<void> completeTodo(String id, bool isComplete);
}

class TodoRepositoryImpl implements TodoRepository {
  final Network client;

  const TodoRepositoryImpl({required this.client});

  @override
  Future<List<Todo>> getTodos() async {
    bool connection = await locator.get<ConnectivityService>().check();

    List<Todo> result = [];

    if (connection) {
      //Network
      final json = await client.get(api: Api.todos) as List;
      result = json.map((e) => Todo.fromJson(e)).toList();
    } else {
      // Local
      List<Map<String, Object?>> data = await SqlDatabase.readAll(
        table: Table.todos,
      );
      result = data.map((e) => Todo.fromJson(e)).toList();
    }
    return result;
  }

  @override
  Future<Todo> getTodo(String id) async {
    bool connection = await locator.get<ConnectivityService>().check();
    late Todo todo;
    if (connection) {
      // Network
      todo = Todo.fromJson(
        await client.get(api: Api.todos, id: id) as Map<String, dynamic>,
      );
    } else {
      Map<String, Object?> data =
          await SqlDatabase.read(table: Table.todos, id: id);
      todo = Todo.fromJson(data);
    }

    return todo;
  }

  @override
  Future<void> completeTodo(String id, bool isComplete) async {
    bool connection = await locator.get<ConnectivityService>().check();
    if (connection) {
      await client.patch(
          api: Api.todos, data: {"isComplete": isComplete}, id: id);
    } else {
      SqlDatabase.update(
        table: Table.todos,
        data: {
          "isComplete": isComplete,
          "sync": Sync.update.ts(),
        },
        id: id,
      );
    }
  }

  @override
  Future<void> createTodo(Todo todo) async {
    bool connection = await locator.get<ConnectivityService>().check();
    Map<String, dynamic> data = todo.toJson();

    if (connection) {
      data["sync"] = Sync.right.ts();
      await client.post(api: Api.todos, data: data);
    } else {
      data["sync"] = Sync.create.ts();
      SqlDatabase.insert(table: Table.todos, data: data);
    }
  }

  @override
  Future<bool> deleteTodo(String id) async {
    bool connection = await locator.get<ConnectivityService>().check();
    if (connection) {
      final json = await client.delete(api: Api.todos, id: id);
      return json != null;
    } else {
      try {
        SqlDatabase.update(
          table: Table.todos,
          data: {
            "sync": Sync.delete.ts(),
          },
          id: id,
        );
        return true;
      }catch(e) {
        return false;
      }
    }
  }

  @override
  Future<Todo> updateTodo(String id, Todo todo) async {
    bool connection = await locator.get<ConnectivityService>().check();
    if (connection) {
      final json = await client.put(api: Api.todos, data: todo.toJson(), id: id)
          as Map<String, dynamic>;
      return Todo.fromJson(json);
    } else {
      SqlDatabase.update(
        table: Table.todos,
        data: {
          "sync": Sync.delete.ts(),
        },
        id: id,
      );
      return getTodo(id);
    }
  }
}

class SqlTodoRepository {
  static void getTodos() {}
}
