import 'package:flutter/material.dart';
import 'package:kabakv1/models/lesson.dart';
import 'package:kabakv1/screens/lessons/lessonAdd.dart';
import 'package:kabakv1/screens/lessons/lessonCard.dart';
import 'package:kabakv1/services/database.dart';
import 'package:kabakv1/shared/loading.dart';

class Lessons extends StatefulWidget {
  @override
  _LessonsState createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Lesson>>(
        stream: DatabaseService().lessonListStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            return ScaffoldForLessons(lessons: snapshot.data);
          }
        });
  }
}

class ScaffoldForLessons extends StatelessWidget {
  const ScaffoldForLessons({
    Key key,
    @required List<Lesson> lessons,
  })  : _lessons = lessons,
        super(key: key);

  final List<Lesson> _lessons;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.grey,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LessonAdd(),
                    ),
                  );
                },
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey,
                size: 35,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            pinned: true,
            expandedHeight: 250,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.grey,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Lessons',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonCard(
                          lessonData: _lessons[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.teal[100 * (index % 9)],
                    alignment: Alignment.center,
                    child: Text(_lessons[index].name),
                  ),
                );
              },
              childCount: _lessons.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.0,
            ),
          )
        ],
      ),
    );
  }
}
