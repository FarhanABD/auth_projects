import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_final/home_screen.dart';
import 'login.dart';
import 'maps_screen.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  registerSubmit() async {
    //create user
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: _emailController.text.toString().trim(),
          password: _passwordController.text);

      addUserDetails(_emailController.text.trim(), _nameController.text.trim(),
          _noController.text.trim(), _passwordController.text.trim());
    } catch (e) {
      print(e);
      SnackBar(
        content: Text(e.toString()),
      );
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (c) => LoginScreen()));
    const snackBar = SnackBar(content: Text("Berhasil Register"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future addUserDetails(
      String email, String nama, String NoTelepon, String Password) async {
    await FirebaseFirestore.instance.collection('users').add({
      'email': email,
      'nama': nama,
      'Nomor Telepon': NoTelepon,
      'password': Password
    });
  }

  loginSumbimt() async {
    try {
      _firebaseAuth
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen())));
    } catch (e) {
      print(e);
      SnackBar(
        content: Text(e.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.red,
      body: Stack(children: [
        Container(
          margin: EdgeInsets.only(top: 400),
          width: double.infinity,
          height: 700,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40), topLeft: Radius.circular(40)),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          margin: EdgeInsets.only(top: 200, left: 50, right: 50),
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0.1, blurRadius: 5)
              ]),
          child: Column(children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Email",
                  labelStyle: TextStyle(fontSize: 12)),
            ),
            TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password",
                  labelStyle: TextStyle(fontSize: 12)),
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_pin_rounded),
                  labelText: "Nama",
                  labelStyle: TextStyle(fontSize: 12)),
            ),
            TextFormField(
              controller: _noController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  labelText: "No Telp",
                  labelStyle: TextStyle(fontSize: 12)),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 8)),
            ElevatedButton(
              child: const Text('Register'),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0))),
              onPressed: () {
                registerSubmit();
              },
            ),
            Row(
              children: <Widget>[
                const Text(
                  'Already have an account?',
                  style: TextStyle(fontSize: 12),
                ),
                TextButton(
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    }),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ]),
        ),
        Positioned(
          top: 85,
          left: 55,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Register",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Text(
              "Create new account",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 17),
            ),
          ]),
        )
      ]),
    );
  }
}
