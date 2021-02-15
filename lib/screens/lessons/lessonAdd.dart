import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:kabakv1/services/database.dart';
import 'package:kabakv1/shared/constants.dart';

class LessonAdd extends StatefulWidget {
  @override
  _LessonAddState createState() => _LessonAddState();
}

class _LessonAddState extends State<LessonAdd> {
  List<String> daysOfTheWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  String _selectedDay = '';
  String _selectedName = '';
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
            size: 35,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.orange),
              child: Text(transformTimeForDatabaseToString(
                  _startTime, _endTime, _selectedDay)),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                decoration: inputDecoration.copyWith(labelText: 'Name'),
                initialValue: 'New Lesson',
                onChanged: (value) {
                  setState(() {
                    return _selectedName = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                    onPressed: () async {
                      final TimeOfDay picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        helpText: 'Starting time',
                      );

                      if (picked != null && picked != _startTime)
                        setState(() {
                          _startTime = picked;
                        });
                    },
                    child: Text(
                      'Starting time\n${_startTime.hour}.${_startTime.minute}',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    )),
                RaisedButton(
                    onPressed: () async {
                      final TimeOfDay picked = await showTimePicker(
                        context: context,
                        initialTime: _endTime,
                        helpText: 'Ending time',
                      );

                      if (picked != null && picked != _endTime)
                        setState(() {
                          _endTime = picked;
                        });
                      // print('$endTime   $startTime');
                    },
                    child: Text(
                      'Ending time\n${_endTime.hour}.${_endTime.minute}',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    )),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
              margin: EdgeInsets.all(10),
              child: DropdownButtonFormField(
                autovalidate: true,
                decoration: inputDecoration.copyWith(
                  labelText: 'Day',
                ),
                items: daysOfTheWeek
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    return _selectedDay = value;
                  });
                },
              ),
            ),
            RaisedButton.icon(
                onPressed: () async {
                  await DatabaseService().updateLessonData(
                      name: _selectedName,
                      attendees: [],
                      date: transformTimeForDatabaseToString(
                          _startTime, _endTime, _selectedDay));
                  Navigator.pop(context);
                },
                icon: Icon(Icons.add),
                label: Text('Add lesson'))
          ],
        ),
      ),
    );
  }
}

String transformTimeForDatabaseToString(
    TimeOfDay start, TimeOfDay end, String day) {
  return '${start.hour}.${start.minute} ${end.hour}.${end.minute} $day';
}
