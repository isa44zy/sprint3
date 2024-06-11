import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsgo/model/Veterinario.dart';

class Veterinarioservice{
  static const String baseUrl = 'http://10.121.138.180:8080/veterinario/';

  Future<List<Veterinario>> buscarVeterinarios() async{
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200){
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Veterinario.fromJson(item)). toList();
    } else {
      throw Exception('Falha ao carregar Veterinario');
    }
  }
   Future<void> criarVeterinario(Veterinario Veterinario)async{
     final response = await http.post(
       Uri.parse(baseUrl),
       headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
       body: jsonEncode(Veterinario.toJson()),
     );
     if (response.statusCode != 201) {
       throw Exception('Falha ao criar Veterinario');
     }
   }
   Future<void> atualizarVeterinario(Veterinario Veterinario) async{
     final response = await http.put(
       Uri.parse('$baseUrl${Veterinario.id}'),
       headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
       body: jsonEncode(Veterinario.toJson()),
     );
     if (response.statusCode != 200){
       throw Exception('Falha ao atualizar Veterinario');
     }
   }
   Future<void> deletarVeterinario(int id) async{
     final response = await http.delete(Uri.parse('$baseUrl$id'));
     if (response.statusCode == 204){
       print('Veterinario deletado com sucesso');
     } else {
       print('Erro ao deletar Veterinario: ${response.statusCode} ${response.body}');
       throw Exception('Falha ao deletar Veterinario');
     }
   }
}