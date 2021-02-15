import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kabakv1/screens/authentication/authentication.dart';
import 'package:kabakv1/screens/home/home.dart';
import 'package:kabakv1/screens/lessons/lessons.dart';
import 'package:kabakv1/screens/settings/settings.dart';
import 'package:kabakv1/screens/students/students.dart';
import 'package:kabakv1/screens/wrapper.dart';
import 'package:kabakv1/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        routes: {
          '/authenticate': (context) => Authenticate(),
          '/wrapper': (context) => Wrapper(),
          '/home': (context) => Home(),
          '/lessons': (context) => Lessons(),
          '/students': (context) => Students(),
          '/settingsPage': (context) => SettingsPage(),
        },
        theme: ThemeData(fontFamily: 'Raleway'),
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
