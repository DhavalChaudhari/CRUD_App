import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = FirebaseFirestore.instance;
  late String task;

  @override
  Widget build(BuildContext context) {
    var a;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showdialog(false, a),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Crud App"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection("task").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data!.docs[index];
                return Container(
                  child: ListTile(
                    //leading: Text(),
                    title: Text(ds['task']),
                    trailing: Wrap(
                      children: [
                        IconButton(
                          onPressed: () {
                            db.collection('task').doc(ds.id).delete();
                          },
                          icon: Icon(Icons.remove_circle_outline_rounded),
                        ),
                        IconButton(
                            onPressed: () {
                              showdialog(true, ds);
                            },
                            icon: Icon(Icons.edit_rounded))
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return CircularProgressIndicator();
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      drawer: Drawer(),
    );
  }

  Future<void> showdialog(bool isUpdate, DocumentSnapshot ds) async {
    //await Firebase.initializeApp();
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: isUpdate ? Text("Update Todo") : Text("Add Todo"),
            content: Form(
              autovalidateMode: AutovalidateMode.always,
              key: formkey,
              child: TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Task",
                ),
                validator: (_val) {
                  if (_val!.isEmpty) {
                    return "Can't be Emplty";
                  } else {
                    return null;
                  }
                },
                onChanged: (_val) {
                  task = _val;
                },
              ),
            ),
            // ignore: deprecated_member_use
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  if (isUpdate) {
                    db.collection('task').doc(ds.id).update({'task': task});
                  } else {
                    db.collection('task').add({'task': task});
                    //Navigator.pop(context);
                  }
                  Navigator.pop(context);
                },
//                child: isUpdate ? Text("Update") : Text("Add"),
                child: Text("Add"),
              )
            ],
          );
        });
  }
}
