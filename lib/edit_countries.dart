import 'package:crud_app/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'database.dart';

// ignore: must_be_immutable
class EditCountries extends StatefulWidget {
  EditCountries({Key? key, required this.country, required this.db})
      : super(key: key);
  Map country;
  Database db;

  @override
  _EditCountriesState createState() => _EditCountriesState();
}

class _EditCountriesState extends State<EditCountries> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController codeController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    print(widget.country);
    nameController.text = widget.country['name'];
    codeController.text = widget.country['code'];
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Country'),
      content: Form(
        child: Wrap(
          children: [
            TextFormField(
              controller: nameController,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Country Name",
              ),
            ),
            SizedBox(
              height: 70,
            ),
            TextFormField(
              controller: codeController,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Country Code",
              ),
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              widget.db.update(
                widget.country['id'],
                nameController.text,
                codeController.text,
              );
              Navigator.pop(context, true);
            },
            child: Text('Edit'),
            //style: ButtonStyle(alignment: Alignment.center),
          ),
        )
      ],
    );
  }
}
