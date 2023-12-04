import 'package:http/http.dart' as http;
import './models.dart';
import 'dart:io';
import 'dart:convert';

const DOMAIN = "http://127.0.0.1:8000/api";
const TOKEN = "Token aaad5afa5807d44a576332c389019929977f6bc5";

Future<List<TaskList>> fetchTaskList() async {
  final req = await http.get(
    Uri.parse('$DOMAIN/tasklist/'),
    headers: {
      HttpHeaders.authorizationHeader: TOKEN,
    },
  );
  final List body = json.decode(req.body);
  return body.map((e) => TaskList.fromJson(e)).toList();
}

Future<List<Task>> fetchTask(int id) async {
  final req = await http.get(
    Uri.parse("$DOMAIN/task/tasklist/${id}"),
    headers: {
      HttpHeaders.authorizationHeader: TOKEN,
    },
  );
  final List body = json.decode(req.body);
  return body.map((e) => Task.fromJson(e)).toList();
}

Future<void> updateTask(int id, bool status) async {
  var change = "true";
  if (status) {
    change = "false";
  }
  await http.patch(
    Uri.parse("$DOMAIN/task/$id/"),
    body: {
      "is_done": change,
    },
    headers: {
      HttpHeaders.authorizationHeader: TOKEN,
    },
  );
}
