import 'login.dart';
import 'navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:project_final/navigation_drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red[200],
      ),
      body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text(
              "Selamat Datang",
              style: TextStyle(
                  backgroundColor: Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )
          ])),
    );
  }
}
