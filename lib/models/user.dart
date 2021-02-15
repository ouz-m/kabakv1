class UserData {
  String uid;
  String name;
  String email;
  String registerationDate;
  bool sex;
  bool isAdmin;

  int totalCredit;
  List<dynamic> activeLessons;

  UserData({
    this.uid,
    this.name,
    this.email,
    this.registerationDate,
    this.sex,
    this.isAdmin,
    this.totalCredit,
    this.activeLessons,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': this.uid,
      'name': this.name,
      'email': this.email,
      'registreationDate': this.registerationDate,
      'sex': this.sex,
      'isAdmin': this.isAdmin,
      'totalCredit': this.totalCredit,
      'activeLessons': this.activeLessons,
    };
  }
}
