import 'package:flutter/material.dart';
import 'navigation_drawer.dart';
import 'package:project_final/search_screen.dart';

import 'profile_screen.dart';
import 'dashboard_sceen.dart';
import 'maps_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;
  final List<Widget> screens = [
    DashboardScreen(),
    SearchScreen(),
    MapsScreen(),
    ProfileScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = DashboardScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 95,
                    onPressed: () {
                      setState(() {
                        currentScreen = DashboardScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0
                              ? Colors.pink.shade100
                              : Colors.white,
                        ),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                              fontSize: 11,
                              color:
                                  currentTab == 0 ? Colors.red : Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        minWidth: 95,
                        onPressed: () {
                          setState(() {
                            currentScreen = SearchScreen();
                            currentTab = 1;
                            //Navigator.push(
                            //context,
                            //MaterialPageRoute(
                            //builder: (context) => SearchScreen()));
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search,
                                color: currentTab == 1
                                    ? Colors.red[300]
                                    : Colors.white),
                            Text(
                              'Search',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: currentTab == 1
                                      ? Colors.red[300]
                                      : Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 95,
                    onPressed: () {
                      setState(() {
                        currentScreen = MapsScreen();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.maps_ugc,
                          color: currentTab == 2
                              ? Colors.pink.shade100
                              : Colors.white,
                        ),
                        Text(
                          'Maps',
                          style: TextStyle(
                              fontSize: 11,
                              color: currentTab == 2
                                  ? Colors.pink.shade100
                                  : Colors.white),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 90,
                    onPressed: () {
                      setState(() {
                        currentScreen = ProfileScreen();
                        currentTab = 3;
                        //Navigator.push(
                        //context,
                        //MaterialPageRoute(
                        //builder: (context) => ChatScreen()));
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab == 3
                              ? Colors.pink.shade100
                              : Colors.white,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              fontSize: 11,
                              color: currentTab == 3
                                  ? Colors.pink.shade100
                                  : Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
