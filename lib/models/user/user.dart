import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app_provider/models/todo/todo.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String createdAt,
    required String name,
    required String avatar,
    required String password,
    required List<Todo>? todos,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
