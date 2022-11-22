import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'login.dart';
import 'package:geolocator/geolocator.dart';
import 'main.dart';

import 'package:android_intent_plus/android_intent.dart';
import 'package:platform/platform.dart';

class MapsScreen extends StatefulWidget {
  MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  //Future<void> _signOut() async {
  //await FirebaseAuth.instance.signOut();
  //Navigator.pushReplacementNamed(
  //context,
  //MaterialPageRoute(builder: (c) => MyApp()));
  // ignore: use_build_context_synchronouslye
  //}

  //get location
  int _counter = 0;

  String location = 'Belum Mendapatkan Lat dan long, Silahkan tekan button';
  String address = 'Mencari lokasi...';
  //getLongLAT
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //location service not enabled, don't continue
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location service Not Enabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }
    //permission denied forever
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permission denied forever, we cannot access',
      );
    }
    //continue accessing the position of device
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      print(auth.currentUser!.email);
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          title: Text("Maps"),
          actions: <Widget>[
            //IconButton(
            //icon: Icon(Icons.exit_to_app),
            //onPressed: _signOut,
            //),
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Koordinat Point",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                location,
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'address',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${address}',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  Position position = await _getGeoLocationPosition();
                  setState(() {
                    location = '${position.latitude}, ${position.longitude}';
                  });
                  getAddressFromLongLat(position);
                },
                child: const Text('Get Koordinat'),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red[200],
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red[200],
            child: const Icon(
              Icons.location_on,
              color: Color.fromARGB(255, 225, 151, 176),
            ),
            onPressed: () {
              final intent = AndroidIntent(
                  action: 'action_view',
                  data: Uri.encodeFull(
                      'google.navigation:1=Tarongo+Zoo,+Sydney+Australia&avoid=tf'),
                  package: 'com.google.android.apps.maps');
              intent.launch();

              child:
              Icon(
                Icons.pin_drop,
                color: Color.fromARGB(179, 255, 255, 255),
                size: 20,
              );
            }));
  }

  Future<void> getAddressFromLongLat(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    setState(() {
      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    });
  }
}
