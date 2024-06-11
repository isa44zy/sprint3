import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsgo/model/Proprietario.dart';

class Proprietarioservice{
  static const String baseUrl = 'http://10.121.138.180:8080/proprietario/';

  Future<List<Proprietario>> buscarProprietarios() async{
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200){
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Proprietario.fromJson(item)). toList();
    } else {
      throw Exception('Falha ao carregar Proprietario');
    }
  }

  Future<void> criarProprietario(Proprietario Proprietario)async{
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(Proprietario.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao criar Proprietario');
    }
  }
  Future<void> atualizarProprietario(Proprietario Proprietario) async{
    final response = await http.put(
      Uri.parse('$baseUrl${Proprietario.id}'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(Proprietario.toJson()),
    );
    if (response.statusCode != 200){
      throw Exception('Falha ao atualizar Proprietario');
    }
  }
  Future<void> deletarProprietario(int id) async{
    final response = await http.delete(Uri.parse('$baseUrl$id'));
    if (response.statusCode == 204){
      print('Proprietario deletado com sucesso');
    } else {
      print('Erro ao deletar Proprietario: ${response.statusCode} ${response.body}');
      throw Exception('Falha ao deletar Proprietario');
    }
  }
}