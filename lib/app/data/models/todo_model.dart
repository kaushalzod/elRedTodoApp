// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Todo {
  String? id;
  String? title;
  String? description;
  String? date;
  String? type;
  bool? completed;
  Todo({
    this.id,
    this.title,
    this.description,
    this.date,
    this.type,
    this.completed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'type': type,
      'completed': completed,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      completed: map['completed'] != null ? map['completed'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);
}
