import 'package:http/http.dart' as http;
import 'dart:convert';


const String APIurl = "https://jsonplaceholder.typicode.com";

class API {
  Future<void> methodGet() async {
    final response = await http.get(Uri.parse('$APIurl/posts'));

    if (response.statusCode == 200) {

      List<dynamic> data = json.decode(response.body);
      print(data);
    } else {
      // Ocurrió un error durante la solicitud
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> postData() async {
    final response = await http.post(
      Uri.parse('$APIurl/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': 'Flutter HTTP Example',
        'body': 'This is a sample POST request using Flutter HTTP package.',
        'userId': 1,
      }),
    );
    
    if (response.statusCode == 201) {
      // La solicitud POST fue exitosa
      Map<String, dynamic> data = json.decode(response.body);
      print(data); // Imprime la respuesta de la API en la consola
    } else {
      // Ocurrió un error durante la solicitud POST
      print('Error: ${response.statusCode}');
    }
  }
}