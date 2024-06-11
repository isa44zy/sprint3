import 'package:flutter/material.dart';
import 'package:petsgo/service/VeterinarioService.dart';
import 'package:petsgo/model/Veterinario.dart';


class TelaVeterinario extends StatefulWidget {
  @override
  _TelaVeterinarioState createState() => _TelaVeterinarioState();
}

class _TelaVeterinarioState extends State<TelaVeterinario> {
  late Future<List<Veterinario>> _veterinarios;
  final Veterinarioservice _veterinarioservice = Veterinarioservice();

  /* final TextEditingController _dataController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _pet_idController = TextEditingController();
  final TextEditingController _vet_idController = TextEditingController();

  Veterinario? _VeterinarioAtual;

  @override
  void initState() {
    super.initState();
    _atualizarVeterinario();
  }

  void _atualizarVeterinario() {
    setState(() {
      _Veterinarios = _Veterinarioservice.buscarVeterinarios();
    });
  }

  void _mostrarFormulario({Veterinario? Veterinario}) {
    if (Veterinario != null) {
      _VeterinarioAtual = Veterinario;
      _dataController.text = Veterinario.data;
      _horaController.text = Veterinario.hora;
      _descricaoController.text = Veterinario.descricao;
      _pet_idController.text = Veterinario.pet_id;
      _vet_idController.text = Veterinario.vet_id;
    } else {
      _VeterinarioAtual = null;
      _dataController.clear();
      _descricaoController.clear();
      _horaController.clear();
      _pet_idController.clear();
      _vet_idController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _dataController,
              decoration: InputDecoration(labelText: 'Data'),
            ),
            TextField(
              controller: _horaController,
              decoration: InputDecoration(labelText: 'Hora'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_VeterinarioAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final nome = _nomeController.text;

    if (_VeterinarioAtual == null) {
      final novoVeterinarios = Veterinario(nome: nome);
      await _Veterinarioservice.criarVeterinario(novoVeterinarios);
    }
    else {
      final VeterinariosAtualizado = Veterinario(
        id: _VeterinarioAtual!.id,
        nome: nome,
      );
      await _Veterinarioservice.atualizarVeterinario(VeterinariosAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarVeterinario();
  }

  void _deletarVeterinario(int id) async {
    try {
      await _Veterinarioservice.deletarVeterinario(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veterinarios deletado com sucesso!')));
      _atualizarVeterinario();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar Veterinarios: $error')));
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veterinarios'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => (),
          ),
        ],
      ),
      body: FutureBuilder<List<Veterinario>>(
        future: _veterinarios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final veterinario = snapshot.data![index];
                return ListTile(
                  title: Text(veterinario.nome),
                  subtitle: Text(veterinario.telefoneCelular),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => (),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => (),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
