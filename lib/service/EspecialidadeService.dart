import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsgo/model/Especialidade.dart';

class Especialidadeservice{
  static const String baseUrl = 'http://10.121.138.180:8080/especialidade/';

  Future<List<Especialidade>> buscarEspecialidades() async{
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200){
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Especialidade.fromJson(item)). toList();
    } else {
      throw Exception('Falha ao carregar Especialidade');
    }
  }

  Future<void> criarEspecialidade(Especialidade Especialidade)async{
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(Especialidade.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao criar Especialidade');
    }
  }
  Future<void> atualizarEspecialidade(Especialidade Especialidade) async{
    final response = await http.put(
      Uri.parse('$baseUrl${Especialidade.id}'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(Especialidade.toJson()),
    );
    if (response.statusCode != 200){
      throw Exception('Falha ao atualizar Especialidade');
    }
  }
  Future<void> deletarEspecialidade(int id) async{
    final response = await http.delete(Uri.parse('$baseUrl$id'));
    if (response.statusCode == 204){
      print('Especialidade deletado com sucesso');
    } else {
      print('Erro ao deletar Especialidade: ${response.statusCode} ${response.body}');
      throw Exception('Falha ao deletar Especialidade');
    }
  }
}