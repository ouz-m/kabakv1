import 'package:flutter/material.dart';
import 'package:kabakv1/models/lesson.dart';
import 'package:kabakv1/models/user.dart';
import 'package:kabakv1/services/database.dart';
import 'package:kabakv1/shared/constants.dart';
import 'package:kabakv1/shared/loading.dart';
import 'package:provider/provider.dart';

class Students extends StatefulWidget {
  @override
  _StudentsState createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  List<UserData> _users = [];

  @override
  void initState() {
    super.initState();
    DatabaseService().users.then((value) {
      setState(() {
        _users = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Lesson>>(
      //TO DO: WRONG PLACE
      stream: DatabaseService().lessonListStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData | _users.isEmpty) {
          return Loading();
        } else {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  actions: [],
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.grey,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  pinned: false,
                  expandedHeight: 250,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey,
                    ),
                    // borderRadius: BorderRadius.vertical(
                    //   bottom: Radius.circular(20),
                    // ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'Students',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 4.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return InkWell(
                        child: Container(
                          margin: EdgeInsets.all(2),
                          decoration: gridDecoration,
                          alignment: Alignment.center,
                          child: Text(
                              '${DateTime.parse(_users[0].registerationDate)}'),
                        ),
                      );
                    },
                    childCount: 50,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
