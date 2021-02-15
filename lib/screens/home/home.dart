import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kabakv1/models/user.dart';
import 'package:kabakv1/services/auth.dart';
import 'package:kabakv1/services/database.dart';
import 'package:kabakv1/shared/constants.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // TODO: oyna bunlarla
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    // TO DO: unutma!
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: _sliversList(),
        ),
      ),
    );
  }

  List<Widget> _sliversList() {
    return [
      SliverAppBar(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey,
          ),
          // borderRadius: BorderRadius.vertical(
          //   bottom: Radius.circular(20),
          // ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.grey,
          ),
          onPressed: () async => await _authService.signOut(),
        ),
        pinned: true, // pins the appbar after slide
        expandedHeight: 250, //initial height
        snap: false,
        floating: true, // visibility acces on up scroll

        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            'Main screen',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      SliverGrid(
        delegate: _buildSliverChildListDelegate(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 6.0,
        ),
      ),
    ];
  }

  SliverChildListDelegate _buildSliverChildListDelegate() {
    return SliverChildListDelegate([
      InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/lessons');
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
          child: Container(
            // margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
            decoration: gridDecoration,
            alignment: Alignment.center,
            child: Text(
              'Lessons',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
      ),
      InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/students');
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 20, 10),
          child: Container(
            // margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
            decoration: gridDecoration,
            alignment: Alignment.center,
            child: Text(
              'Students',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
      ),
    ]);
  }
}
