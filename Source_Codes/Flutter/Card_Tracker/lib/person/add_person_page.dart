import 'package:flutter/material.dart';
import 'person.dart';

class AddPersonPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Person'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name Surname'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    phoneNumberController.text.isNotEmpty &&
                    emailController.text.isNotEmpty) {
                  Navigator.pop(
                    context,
                    Person(
                      nameSurname: nameController.text,
                      phoneNumber: phoneNumberController.text,
                      email: emailController.text,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fıll in all fields.'),
                    ),
                  );
                }
              },
              child: Text('Add the person'),
            ),
          ],
        ),
      ),
    );
  }
}
