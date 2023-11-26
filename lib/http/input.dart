import 'dart:async';
import 'dart:convert';
import 'package:hash_test/components/criteria.dart';
import 'package:http/http.dart' as http;


String baseUrlInput = "http://192.168.3.27:8080/input";

Future input(String criteria) async {
  try {
    final response = await http.post(
      Uri.parse(baseUrlInput),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(criteria),
    ).timeout(const Duration(seconds: 5));

    print(criteria);
    print('\n\nResposta input HTTP statuscode: ${response.statusCode}');
    print('Resposta input HTTP body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print("O resultado gerado foi $data");
      return data;
    }
  } catch (e) {
    print('Exceção: $e');
  }
}


Future pegar() async{

  const String url = 'http://192.168.3.27:8080/pegar';

  final response = await http
      .get(Uri.parse(url))
      .timeout(const Duration(seconds: 10), onTimeout: () {
    throw TimeoutException('A requisição ao servidor excedeu o tempo limite.');
  });

  return response.body;

  //print('RESPOSTA: $response');
}

Future pegarCurso() async{

  const String url = 'http://192.168.3.27:8080/pegar';

  final http.Response response = await http.get(Uri.parse(url));

  final List<dynamic> decodedJson = jsonDecode(response.body);

  final List<Criteria> criteria = [];

  for(Map<String, dynamic> criteriaJson in decodedJson){
    final Map<String, dynamic> criterionJson = criteriaJson["criteria"];
  }

  print(response.body);

}