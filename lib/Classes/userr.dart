// ignore_for_file: non_constant_identifier_names

import 'dart:io';

class Userr {
  const Userr({
    required this.uid,
    required this.email,
    required this.photoUrl,
    required this.surname,
    required this.name,
    required this.date_of_birth,
  });

  final String uid;
  final String name;
  final String surname;
  final String date_of_birth;
  final String email;
  final String photoUrl;

  static String sname = "";
  static String ssurname = "";
  static String sUid = "";
  static String sdate_of_birth = "";
  static String sphotoUrl = "";
  static String semail = "";
  static late Future<File> static_image;
}
