import 'package:card_tracker/person/add_person_page.dart';
import 'package:flutter/material.dart';

import 'person.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Person> personList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contacts'),
      ),
      body: ListView.builder(
        itemCount: personList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(personList[index].nameSurname),
            subtitle: Text(personList[index].phoneNumber),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    personList[index].isFavorite
                        ? Icons.star
                        : Icons.star_border,
                    color: personList[index].isFavorite ? Colors.yellow : null,
                  ),
                  onPressed: () {
                    setState(() {
                      personList[index].isFavorite =
                          !personList[index].isFavorite;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Delete the person'),
                          content: Text(
                              'Are you sure you want to delete the person?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  personList.removeAt(index);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newPerson = await Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddPersonPage()));
          if (newPerson != null && newPerson is Person) {
            setState(() {
              personList.add(newPerson);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
