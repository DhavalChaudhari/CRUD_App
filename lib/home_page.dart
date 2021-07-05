import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/add_countries.dart';
import 'package:crud_app/country_list.dart';
import 'package:crud_app/edit_countries.dart';
import 'package:crud_app/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Database db;
  List docs = [];

  initialise() {
    db = Database();
    db.initialise();
    db.read().then((value) => {
          setState(() {
            docs = value;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        "https://th.bing.com/th/id/R037d67c6ae4d20c4b16fffe86a32e1df?rik=3Gj3hriwkPeE8A&riu=http%3a%2f%2fwww.selectspecs.com%2ffashion-lifestyle%2fwp-content%2fuploads%2f2015%2f05%2fGerard-B-1050x700.jpg&ehk=jH4xWc7J7cVNXxHBwDYDhGOPskQ5XX6cnqGYknMSHw8%3d&risl=&pid=ImgRaw";
    return Scaffold(
      backgroundColor: Colors.blueGrey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddCountries(db: db)))
              .then((value) {
            if (value != null) {
              initialise();
            }
          });
        },
        child: Icon(CupertinoIcons.add),
        backgroundColor: Colors.blueGrey[700],
      ),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        title: Text('Crud App'),
      ),
      body: ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            return Container(
              child: ListTile(
                //leading: Text(),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Text(''),
                    Text(
                      docs[index]['name'],
                    ),
                    Text(
                      docs[index]['code'],
                    ),
                  ],
                ),

                trailing: Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        delete("id");
                      },
                      icon: Icon(Icons.remove_circle_outline_rounded),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditCountries(
                                        country: docs[index],
                                        db: db,
                                      ))).then((value) => {
                                if (value != null) {initialise()}
                              });
                        },
                        icon: Icon(Icons.edit_rounded))
                  ],
                ),
              ),
            );
          }),
      drawer: Drawer(
        child: Container(
          child: ListView(
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.blueGrey[700]),
                  margin: EdgeInsets.zero,
                  accountName: Text("Dhaval Chaudhari"),
                  accountEmail: Text("dhaval@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  late FirebaseFirestore firestore;
  Future<void> delete(id) async {
    try {
      await firestore.collection('countries').doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
}
