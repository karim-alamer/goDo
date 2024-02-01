// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

class TaskModel {
  final int? id;
  final String title;
  final String note;
  final String date;
  final String starttime;
  final String endtime;
  final String repeat;
  final int reminder;
  final int colorindex;
  final int? isCompleted;
  Color? taskColor;
  TaskModel({
    this.id,
    required this.title,
    required this.note,
    required this.date,
    required this.starttime,
    required this.endtime,
    required this.repeat,
    required this.reminder,
    required this.colorindex,
    this.isCompleted,
    this.taskColor,
  });

  TaskModel copyWith({
    int? id,
    String? title,
    String? note,
    String? date,
    String? starttime,
    String? endtime,
    String? repeat,
    int? reminder,
    int? colorindex,
    int? isCompleted,
    Color? taskColor,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      date: date ?? this.date,
      starttime: starttime ?? this.starttime,
      endtime: endtime ?? this.endtime,
      repeat: repeat ?? this.repeat,
      reminder: reminder ?? this.reminder,
      colorindex: colorindex ?? this.colorindex,
      isCompleted: isCompleted ?? this.isCompleted,
      taskColor: taskColor ?? this.taskColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'note': note,
      'date': date,
      'starttime': starttime,
      'endtime': endtime,
      'repeat': repeat,
      'reminder': reminder,
      'colorindex': colorindex,
      'isCompleted': isCompleted,
      'taskColor': taskColor,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      note: map['note'] as String,
      date: map['date'] as String,
      starttime: map['starttime'] as String,
      endtime: map['endtime'] as String,
      repeat: map['repeat'] as String,
      reminder: map['reminder'] as int,
      colorindex: map['colorindex'] as int,
      isCompleted:
          map['isCompleted'] != null ? map['isCompleted'] as int : null,
      taskColor: map['taskColor'] != null ? map['taskColor'] as Color : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, note: $note, date: $date, starttime: $starttime, endtime: $endtime, repeat: $repeat, reminder: $reminder, colorindex: $colorindex, isCompleted: $isCompleted,taskColor: $taskColor)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.note == note &&
        other.date == date &&
        other.starttime == starttime &&
        other.endtime == endtime &&
        other.repeat == repeat &&
        other.reminder == reminder &&
        other.colorindex == colorindex &&
        other.isCompleted == isCompleted &&
        other.taskColor == taskColor;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        note.hashCode ^
        date.hashCode ^
        starttime.hashCode ^
        endtime.hashCode ^
        repeat.hashCode ^
        reminder.hashCode ^
        colorindex.hashCode ^
        isCompleted.hashCode ^
        taskColor.hashCode;
  }
}
