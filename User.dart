import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  final String nama;
  final String email;
  final String NomorTelepon;

  User({
    this.id = '',
    required this.nama,
    required this.email,
    required this.NomorTelepon,
  });

  Map<String, dynamic> toJson() =>
      {'uid': id, 'nama': nama, 'email': email, 'Nomer Telepon': NomorTelepon};

  static User fromJson(Map<String, dynamic> json) => User(
      id: json['uid'],
      nama: json['nama'],
      email: json['email'],
      NomorTelepon: json['Nomor Telepon']);
}
