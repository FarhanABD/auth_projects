import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItem(context),
        ],
      )),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        child: Container(
          color: Colors.pink.shade100,
          padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
          child: Column(
            children: const [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('image/asset/jungkook.jpeg'),
              ),
              SizedBox(height: 12),
              Text('M Farhan Abdillah',
                  style: TextStyle(fontSize: 18, color: Colors.black)),
              Text(
                'farhan@gmail.com',
                style: TextStyle(fontSize: 12, color: Colors.black),
              )
            ],
          ),
        ),
      );

  Widget buildMenuItem(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 280),
        child: Wrap(runSpacing: 16, children: [
          ListTile(
            leading: const Icon(Icons.group),
            iconColor: Colors.red,
            title: const Text('Anggota'),
            textColor: Colors.red,
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.music_note),
            iconColor: Colors.red,
            title: const Text('Album'),
            textColor: Colors.red,
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.note_add_rounded),
            iconColor: Colors.red,
            title: const Text('Catatan'),
            textColor: Colors.red,
            onTap: () {},
          ),
          const Divider(color: Color.fromARGB(255, 202, 234, 154)),
          ListTile(
            leading: const Icon(Icons.settings),
            iconColor: Colors.red,
            title: const Text('Pengaturan'),
            textColor: Colors.red,
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            iconColor: Colors.red,
            title: const Text('Logout'),
            textColor: Colors.red,
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (c) => LoginScreen()));
              // ignore: use_build_context_synchronouslye
            },
          ),
        ]),
      );
}
