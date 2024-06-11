import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsgo/model/Consulta.dart';

class Consultaservice{
  static const String baseUrl = 'http://10.121.138.180:8080/consulta/';

  Future<List<Consulta>> buscarConsultas() async{
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200){
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Consulta.fromJson(item)). toList();
    } else {
      throw Exception('Falha ao carregar Consulta');
    }
  }

  Future<void> criarConsulta(Consulta Consulta)async{
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(Consulta.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao criar Consulta');
    }
  }
  Future<void> atualizarConsulta(Consulta Consulta) async{
    final response = await http.put(
      Uri.parse('$baseUrl${Consulta.id}'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(Consulta.toJson()),
    );
    if (response.statusCode != 200){
      throw Exception('Falha ao atualizar Consulta');
    }
  }
  Future<void> deletarConsulta(int id) async{
    final response = await http.delete(Uri.parse('$baseUrl$id'));
    if (response.statusCode == 204){
      print('Consulta deletado com sucesso');
    } else {
      print('Erro ao deletar Consulta: ${response.statusCode} ${response.body}');
      throw Exception('Falha ao deletar Consulta');
    }
  }
}