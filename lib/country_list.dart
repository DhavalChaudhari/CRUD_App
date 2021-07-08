import 'package:crud_app/database.dart';
import 'package:crud_app/delete_country.dart';
import 'package:crud_app/edit_countries.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CountriesList extends StatefulWidget {
  CountriesList({
    Key? key,
  }) : super(key: key);
  //Database db;
  //Map country;
  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
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
    return ListView.builder(
        itemCount: docs.length,
        itemBuilder: (context, index) {
          // Item Builder
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
                  DeleteCountry(db: db, country: docs[index]),
                  //Navigator.pop(context,true),
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
        });
  }
}
