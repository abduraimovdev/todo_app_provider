// import 'package:flutter/cupertino.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
// class HiveService {
//   final Boxes title;
//
//   const HiveService({required this.title});
//
//   Future<void> init() async {
//     await Hive.initFlutter();
//   }
//
//   Future<void> createBox<T>({Boxes? title}) async {
//       await Hive.openBox<T>((title ?? this.title).name);
//   }
//
//   Future<void> deleteBox({Boxes? title}) async {
//     await Hive.deleteBoxFromDisk((title ?? this.title).name);
//   }
//
//   Future<bool> delete<T>(String key, {Boxes? title}) async {
//     try {
//       final box = Hive.box<T>((title ?? this.title).name);
//       await box.delete(key);
//       return true;
//     } catch (e) {
//       debugPrint("Log Error msg: $e");
//       return false;
//     }
//   }
//
//   T? read<T>(String key, {Boxes? title, T? defaultValue}) {
//     final box = Hive.box<T>((title ?? this.title).name);
//     return box.get(key, defaultValue: defaultValue)!;
//   }
//
//   Future<void> save<T>(String key, T data, {Boxes? title}) async {
//     final box = Hive.box<T>((title ?? this.title).name);
//     await box.put(key, data);
//   }
// }
//
// enum Boxes {
//   settings,
//   userInfo,
// }
