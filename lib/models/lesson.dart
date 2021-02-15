class Lesson {
  String uid;
  String name;
  String date;

  List<String> attendees;

  Lesson({
    this.uid,
    this.name,
    this.date,
    this.attendees,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': this.uid,
      'name': this.name,
      'date': this.date,
      'attendees': this.attendees,
    };
  }
}
