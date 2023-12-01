import 'package:http/http.dart' as http;
import './models.dart';
import 'dart:io';
import 'dart:convert';

Future<List<TaskList>> fetchTaskList() async {
  final req = await http.get(
    Uri.parse('http://127.0.0.1:8000/api/tasklist/'),
    headers: {
      HttpHeaders.authorizationHeader:
          'Token aaad5afa5807d44a576332c389019929977f6bc5',
    },
  );
  final List body = json.decode(req.body);
  return body.map((e) => TaskList.fromJson(e)).toList();
}

Future<List<Task>> fetchTask(int id) async {
  final req = await http.get(
    Uri.parse("http://127.0.0.1:8000/api/task/tasklist/${id}"),
    headers: {
      HttpHeaders.authorizationHeader:
          'Token aaad5afa5807d44a576332c389019929977f6bc5',
    },
  );
  final List body = json.decode(req.body);
  return body.map((e) => Task.fromJson(e)).toList();
}
