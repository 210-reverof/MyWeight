import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String profileName;
  String userName;
  String email;
  String image;
  String macAddress;
  double goalWeight;
  List<dynamic> recentWeight;
  Timestamp regDate;
  List<dynamic> recentDate;

  User({
    this.id,
    this.profileName,
    this.userName,
    this.email,
    this.image,
    this.macAddress,
    this.goalWeight,
    this.recentWeight,
    this.regDate,
    this.recentDate
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    Map getDocs = doc.data();
    return User(
        id: doc.id,
        email: getDocs["email"],
        userName: getDocs["userName"],
        profileName: getDocs["profileName"],
        image: getDocs["image"],
        macAddress: getDocs["macAddress"],
        goalWeight: getDocs["goalWeight"],
        recentWeight: getDocs["recentWeight"],
        regDate: getDocs["regDate"],
        recentDate: getDocs["recentDate"]
    );
  }
}