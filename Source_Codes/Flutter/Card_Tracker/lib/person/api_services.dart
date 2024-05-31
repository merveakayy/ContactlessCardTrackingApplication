import 'dart:convert';
import 'package:card_tracker/person/person.dart';
import 'package:http/http.dart' as http;

Future<void> sendPersonDataToDotNet(Person person) async {
  final Uri uri = Uri.parse('http://your-dotnet-api-url.com/persons');

  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(person.toJson()),
  );

  if (response.statusCode == 200) {
    print('Person data sent successfully');
  } else {
    print('Failed to send person data: ${response.reasonPhrase}');
  }
}
