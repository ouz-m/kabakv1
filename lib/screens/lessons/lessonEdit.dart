import 'package:flutter/material.dart';
import 'package:kabakv1/models/lesson.dart';

class LessonEdit extends StatefulWidget {
  Lesson currentLesson;
  @override
  _LessonEditState createState() => _LessonEditState();
}

class _LessonEditState extends State<LessonEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
