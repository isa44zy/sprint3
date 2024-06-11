import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsgo/model/Pet.dart';

class Petservice{
  static const String baseUrl = 'http://10.121.138.180:8080/pet/';

  Future<List<Pet>> buscarPets() async{
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200){
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Pet.fromJson(item)). toList();
    } else {
      throw Exception('Falha ao carregar Pet');
    }
  }

  Future<void> criarPet(Pet Pet)async{
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(Pet.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao criar Pet');
    }
  }
  Future<void> atualizarPet(Pet Pet) async{
    final response = await http.put(
      Uri.parse('$baseUrl${Pet.id}'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(Pet.toJson()),
    );
    if (response.statusCode != 200){
      throw Exception('Falha ao atualizar Pet');
    }
  }
  Future<void> deletarPet(int id) async{
    final response = await http.delete(Uri.parse('$baseUrl$id'));
    if (response.statusCode == 204){
      print('Pet deletado com sucesso');
    } else {
      print('Erro ao deletar Pet: ${response.statusCode} ${response.body}');
      throw Exception('Falha ao deletar Pet');
    }
  }
}