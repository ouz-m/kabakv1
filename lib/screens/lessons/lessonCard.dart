import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kabakv1/models/lesson.dart';
import 'package:kabakv1/models/user.dart';
import 'package:kabakv1/screens/lessons/lessonEdit.dart';
import 'package:kabakv1/services/database.dart';
import 'package:kabakv1/shared/loading.dart';
import 'package:provider/provider.dart';

class LessonCard extends StatefulWidget {
  final Lesson lessonData;

  const LessonCard({Key key, this.lessonData}) : super(key: key);

  @override
  _LessonCardState createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> {
  @override
  void initState() {
    super.initState();
    DatabaseService()
        .userDataFromUIDlist(widget.lessonData.attendees)
        .then((value) {
      setState(() {
        attendeeList = value;
      });
    });
  }

  //
  List<UserData> attendeeList = [];
  //
  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<User>(context);
    return StreamBuilder<Lesson>(
      stream:
          DatabaseService(lessonUid: widget.lessonData.uid).lessonStreamFromUID,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        } else {
          List<String> _splittedTimeTimeDate = snapshot.data.date.split(' ');
          return Scaffold(
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.grey,
                elevation: 0,
                child: Icon(Icons.attach_file),
                onPressed: () async {
                  if (snapshot.data.attendees.contains(currentUser.uid)) {
                    return await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text('You are already assigned to this class'),
                              SizedBox(height: 10),
                              Text(
                                  'Push and hold "Delete" button to delete your attendance'),
                            ],
                          ),
                        ),
                        actions: [
                          FlatButton(
                              onPressed: () async {
                                snapshot.data.attendees.remove(currentUser.uid);
                                await DatabaseService(
                                        lessonUid: snapshot.data.uid)
                                    .updateLessonData(
                                        name: snapshot.data.name,
                                        date: snapshot.data.date,
                                        attendees: snapshot.data.attendees);
                              },
                              child: Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              )),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Continue'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    snapshot.data.attendees.add(currentUser.uid);
                    DatabaseService(lessonUid: snapshot.data.uid)
                        .updateLessonData(
                            name: snapshot.data.name,
                            date: snapshot.data.date,
                            attendees: snapshot.data.attendees);
                  }
                }),
            body: RefreshIndicator(
              color: Colors.white,
              backgroundColor: Colors.grey,
              displacement: 120,
              onRefresh: () {
                return DatabaseService()
                    .userDataFromUIDlist(snapshot.data.attendees)
                    .then((value) {
                  setState(() {
                    attendeeList = value;
                  });
                });
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 250,
                    elevation: 0,
                    floating: false,
                    pinned: true,
                    backgroundColor: Colors.white,
                    //
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.grey,
                        size: 35,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    //
                    actions: [
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.edit,
                      //     color: Colors.grey,
                      //     size: 30,
                      //   ),
                      // onPressed: () => LessonEdit(Lesson snapshot.data),
                      // ),
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.refresh,
                      //     color: Colors.grey,
                      //     size: 30,
                      //   ),
                      //   onPressed: () => DatabaseService()
                      //       .userDataFromUIDlist(snapshot.data.attendees)
                      //       .then((value) {
                      //     setState(() {
                      //       attendeeList = value;
                      //     });
                      //   }),
                      // ),
                    ],
                    //
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        color: Colors.white,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${_splittedTimeTimeDate[0]} --- ${_splittedTimeTimeDate[1]}',
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${_splittedTimeTimeDate[2]}',
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        )),
                      ),
                      title: Text(
                        '${snapshot.data.name}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    //
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return InkWell(
                          child: Container(
                            padding: EdgeInsets.only(left: 15),
                            alignment: Alignment.center,
                            color: Colors.teal[100 * (index % 9)],
                            child: Text(attendeeList[index].email),
                          ),
                        );
                      },
                      childCount: attendeeList.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 3),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
