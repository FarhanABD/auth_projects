import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(const ProfileScreen());
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      home: const Profile(title: 'Profile'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Profile> createState() => _ProfileState();
}

//class _ProfileState extends State<Profile> {
//@override
//Widget build(BuildContext context) {
//return Scaffold(
//appBar: AppBar(
//backgroundColor: Colors.black,
//title: Text(widget.title),
//),
//);
//}
//}

class _ProfileState extends State<Profile> {
  // Future<void> _signOut() async {
  //   await FirebaseAuth.instance.signOut();
  // }

  //read
  List<String> docIDs = [];

  //get docIDs
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  @override
  void initState() {
    getDocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      print(auth.currentUser!.email);
    }
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[200],
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: Text(
              '${auth.currentUser!.email}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              //fontWeight: FontWeight.bold),
            ),
            actions: [
              // IconButton(
              //     icon: Icon(Icons.logout),
              //     onPressed: () {
              //       _signOut().then(
              //         (value) => Navigator.of(context).pushReplacement(
              //           MaterialPageRoute(
              //             builder: (context) => const Login(),
              //           ),
              //         ),
              //       );
              //     }),
            ]),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(
                //   '${auth.currentUser!.email}',
                //   style: whiteTextStyle.copyWith(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       color: blackColor),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                Expanded(
                  child: FutureBuilder(
                      future: getDocId(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                            itemCount: docIDs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: GetUserName(documentId: docIDs[index]),
                                  tileColor: Colors.amber[50],
                                ),
                              );
                            });
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;
  GetUserName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    //getcollection
    CollectionReference Users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: Users.doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                  ),
                  Text(
                    'Nama : ${data['nama']}',
                    style: TextStyle(color: Colors.black),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                  ),
                  Text(
                    'Email : ${data['email']}',
                    style: TextStyle(color: Colors.black),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                  ),
                  Text(
                    'Nomor Telepon : ${data['Nomor Telepon']}',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                      child: Text("Edit",
                          style: TextStyle(color: Colors.pink.shade100)),
                      onPressed: () {
                        final docUser =
                            FirebaseFirestore.instance.collection('users');
                      }),
                  TextButton(
                      child: Text("Delete",
                          style: TextStyle(color: Colors.pink.shade100)),
                      onPressed: () {
                        // Users.doc().delete().then((value) => ("Data berhasil di hapus"),
                        // onError: (e) => ("Terjadi Kesalahan"));
                      }),
                ],
              ),
            );
            // Row(
            //   children: [
            //     SizedBox(
            //       child: FloatingActionButton(
            //           backgroundColor: Colors.green,
            //           child: Center(
            //               child: Icon(
            //             Icons.arrow_upward,
            //             color: Colors.white,
            //           )),
            //           onPressed: () {}),
            //     ),
            //     SizedBox(
            //       child: FloatingActionButton(
            //           backgroundColor: Colors.red,
            //           child: Center(
            //               child: Icon(
            //             Icons.delete,
            //             color: Colors.white,
            //           )),
            //           onPressed: () {}),
            //     ),
            //   ],
            // )

          }
          return Text('loading...');
        });
  }
}

class ItemCard extends StatelessWidget {
  final String nama;
  final String email;
  final String password;
  final String NoTelepon;

  //// Pointer to Update Function
  final Function onUpdate;
  //// Pointer to Delete Function
  final Function onDelete;

  ItemCard(this.nama, this.email, this.password, this.NoTelepon,
      {required this.onUpdate, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.transparent)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(nama,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 16)),
              ),
              Text(
                email,
                style: GoogleFonts.poppins(),
              ),
              Text(
                password,
                style: GoogleFonts.poppins(),
              ),
              Text(
                NoTelepon,
                style: GoogleFonts.poppins(),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 60,
                child: FloatingActionButton(
                    backgroundColor: Colors.green[900],
                    child: Center(
                        child: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    )),
                    onPressed: () {
                      if (onUpdate != null) onUpdate();
                    }),
              ),
              SizedBox(
                height: 40,
                width: 60,
                child: FloatingActionButton(
                    backgroundColor: Colors.red[900],
                    child: Center(
                        child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
                    onPressed: () {
                      if (onDelete != null) onDelete();
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}
