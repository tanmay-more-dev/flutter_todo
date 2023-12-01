class TaskList {
  final int? id;
  final String? name;
  final String? desc;
  final String? createdAt;
  final String? updatedAt;

  const TaskList(
      {this.id, this.name, this.desc, this.createdAt, this.updatedAt});

  factory TaskList.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'desc': String desc,
        'created_at': String createdAt,
        'updated_at': String updatedAt,
      } =>
        TaskList(
          id: id,
          name: name,
          desc: desc,
          createdAt: createdAt,
          updatedAt: updatedAt,
        ),
      _ => throw const FormatException('Failed to load Tasklist.'),
    };
  }
}

class Task {
  int? id;
  int? tasklist;
  String? title;
  String? desc;
  String? createdAt;
  String? updatedAt;
  bool? isDone;

  Task(
      {this.id,
      this.tasklist,
      this.title,
      this.desc,
      this.createdAt,
      this.updatedAt,
      this.isDone});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tasklist = json['tasklist'];
    title = json['title'];
    desc = json['desc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDone = json['is_done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tasklist'] = this.tasklist;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_done'] = this.isDone;
    return data;
  }
}
