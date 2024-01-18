import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  int? id;
  String? docId;
  String? title;
  String? note;
  bool? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? remind;

  Task({
    this.id,
    this.docId,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.remind,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['note'] = this.note;
    data['isCompleted'] = this.isCompleted;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['remind'] = this.remind;

    return data;
  }

  // Task.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   title = json['title'].toString();
  //   note = json['note'].toString();
  //   isCompleted = json['isCompleted'];
  //   date = json['date'];
  //   startTime = json['startTime'];
  //   endTime = json['endTime'];
  //   remind = json['remind'];
  // }
  factory Task.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data();
    return Task(
    id : json?['id'],
    docId: document.id,
    title : json?['title'].toString(),
    note : json?['note'].toString(),
    isCompleted : json?['isCompleted'],
    date : json?['date'],
    startTime : json?['startTime'],
    endTime : json?['endTime'],
    remind : json?['remind'],
    );
  }
}
