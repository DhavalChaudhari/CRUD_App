import 'package:crud_app/database.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddCountries extends StatefulWidget {
  AddCountries({Key? key, required this.db}) : super(key: key);
  Database db;

  @override
  _AddCountriesState createState() => _AddCountriesState();
}

class _AddCountriesState extends State<AddCountries> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController codeController = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Country'),
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
              widget.db.add(nameController.text, codeController.text);
              Navigator.pop(context, true);
            },
            child: Text('Add'),
            //style: ButtonStyle(alignment: Alignment.center),
          ),
        )
      ],
    );
  }
}
