import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kabakv1/models/lesson.dart';
import 'package:kabakv1/models/user.dart';

class DatabaseService {
  final String userUid;
  final String lessonUid;
  DatabaseService({this.userUid, this.lessonUid});

  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference lessonCollection =
      FirebaseFirestore.instance.collection('Lessons');

  Future<bool> doesUserExists() async {
    try {
      return await userDataCollection.doc(userUid).get().then((value) {
        return value.data().isNotEmpty;
      });
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future get users async {
    QuerySnapshot qShot = await userDataCollection.get();

    return qShot.docs
        .map(
          (e) => UserData(
            email: e.data()['email'],
            activeLessons: e.data()['activeLessons'],
            isAdmin: e.data()['isAdmin'],
            name: e.data()['name'],
            registerationDate: e.data()['registerationDate'],
            sex: e.data()['sex'],
            totalCredit: e.data()['totalCredit'],
            uid: e.data()['uid'],
          ),
        )
        .toList();
  }

  Future<List<UserData>> getUserDataForAssignedLesson() async {
    QuerySnapshot qShot = await userDataCollection
        .where('activeLessons', arrayContains: lessonUid)
        .get();
    return qShot.docs
        .map(
          (e) => UserData(
            email: e.data()['email'],
            activeLessons: e.data()['activeLessons'],
            isAdmin: e.data()['isAdmin'],
            name: e.data()['name'],
            registerationDate: e.data()['registerationDate'],
            sex: e.data()['sex'],
            totalCredit: e.data()['totalCredit'],
            uid: e.data()['uid'],
          ),
        )
        .toList();
  }

  Future<List<Lesson>> getLessonForUserData() async {
    QuerySnapshot qShot =
        await lessonCollection.where('attendees', arrayContains: userUid).get();
    return qShot.docs
        .map(
          (e) => Lesson(
            attendees: List.castFrom(e.data()['attendees']) ?? [],
            date: e.data()['date'],
            name: e.data()['name'],
            uid: e.id,
          ),
        )
        .toList();
  }

  Lesson _lessonDataFromSnapshot(DocumentSnapshot dShot) {
    return Lesson(
      attendees: List.castFrom(dShot.data()['attendees']) ?? [],
      date: dShot.data()['date'],
      name: dShot.data()['name'],
      uid: dShot.id,
    );
  }

  Future get lessons async {
    QuerySnapshot qShot = await lessonCollection.get();

    return qShot.docs
        .map(
          (e) => Lesson(
            attendees: List.castFrom(e.data()['attendees']) ?? [],
            date: e.data()['date'],
            name: e.data()['name'],
            uid: e.id,
          ),
        )
        .toList();
  }

  List<Lesson> _ratingListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Lesson(
        attendees: List.castFrom(e.data()['attendees']) ?? [],
        date: e.data()['date'],
        name: e.data()['name'],
        uid: e.id,
      );
    }).toList();
  }

  Stream<List<Lesson>> get lessonListStream {
    return lessonCollection.snapshots().map(_ratingListFromSnapshot);
  }

  Stream<Lesson> get lessonStreamFromUID {
    return lessonCollection
        .doc(lessonUid)
        .snapshots()
        .map(_lessonDataFromSnapshot);
  }

  Future<List<UserData>> userDataFromUIDlist(List<String> uidList) async {
    try {
      if (uidList.isEmpty) {
        return [UserData(email: 'It is empty')];
      }
      QuerySnapshot qShot =
          await userDataCollection.where('uid', whereIn: uidList).get();

      return qShot.docs
          .map(
            (e) => UserData(
              email: e.data()['email'],
              activeLessons: e.data()['activeLessons'],
              isAdmin: e.data()['isAdmin'],
              name: e.data()['name'],
              registerationDate: e.data()['registerationDate'],
              sex: e.data()['sex'],
              totalCredit: e.data()['totalCredit'],
              uid: e.data()['uid'],
            ),
          )
          .toList();
    } on Exception catch (e) {
      // TODO
      print(e.toString());
      return null;
    }
  }

  Future updateLessonData({
    String name,
    String date,
    List<String> attendees,
  }) async {
    return await lessonCollection.doc(lessonUid).set(
      {
        'name': name,
        'date': date,
        'attendees': attendees,
      },
    );
  }

  Future updateUserData({
    String name,
    String registerationDate,
    String email,
    bool sex,
    int totalCredit,
    List<int> activeLessons,
  }) async {
    return await userDataCollection.doc(userUid).set(
      {
        'uid': userUid,
        'name': name,
        'email': email,
        'registerationDate': registerationDate,
        'sex': sex,
        'isAdmin': false,
        'totalCredit': totalCredit,
        'activeLessons': activeLessons,
      },
    );
  }
}
