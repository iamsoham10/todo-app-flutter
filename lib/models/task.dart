class Task {
  String? id;
  String? userid;
  String? content;
  DateTime? dateadded;
  bool complete;

  Task(
      {this.id,
      this.userid,
      this.content,
      this.dateadded,
      this.complete = false});

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
        id: map["id"],
        userid: map["userid"],
        content: map["content"],
        dateadded: DateTime.tryParse(map["dateadded"]),
        complete: map["complete"] ?? false);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userid": userid,
      "content": content,
      "dateadded": dateadded!.toIso8601String(),
      "complete": complete
    };
  }

  void add(Task task) {}
}
