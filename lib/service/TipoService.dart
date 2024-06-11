import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsgo/model/Tipo.dart';

class Tiposervice{
  static const String baseUrl = 'http://10.121.138.180:8080/tipo/';

  Future<List<Tipo>> buscarTipos() async{
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200){
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Tipo.fromJson(item)). toList();
    } else {
      throw Exception('Falha ao carregar Tipos');
    }
  }

  Future<void> criarTipo(Tipo Tipo)async{
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(Tipo.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao criar Tipos');
    }
  }
  Future<void> atualizarTipo(Tipo Tipo) async{
    final response = await http.put(
      Uri.parse('$baseUrl${Tipo.id}'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(Tipo.toJson()),
    );
    if (response.statusCode != 200){
      throw Exception('Falha ao atualizar Tipos');
    }
  }
  Future<void> deletarTipo(int id) async{
    final response = await http.delete(Uri.parse('$baseUrl$id'));
    if (response.statusCode == 204){
      print('Tipos deletado com sucesso');
    } else {
      print('Erro ao deletar Tipos: ${response.statusCode} ${response.body}');
      throw Exception('Falha ao deletar Tipos');
    }
  }
}