import 'package:crud_app/database.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DeleteCountry extends StatefulWidget {
  DeleteCountry({Key? key, required this.db, required this.country})
      : super(key: key);
  Database db;
  Map country;
  @override
  _DeleteCountryState createState() => _DeleteCountryState();
}

class _DeleteCountryState extends State<DeleteCountry> {
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

  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          widget.db.delete(widget.country['id']);
          Navigator.pop(context, true);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => CountriesList()));
        },
        icon: Icon(Icons.remove_circle_outline));
  }
}
