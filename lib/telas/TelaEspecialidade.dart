import 'package:flutter/material.dart';
import 'package:petsgo/service/EspecialidadeService.dart';
import 'package:petsgo/model/Especialidade.dart';


class TelaEspecialidade extends StatefulWidget {
  @override
  _TelaEspecialidadeState createState() => _TelaEspecialidadeState();
}

class _TelaEspecialidadeState extends State<TelaEspecialidade> {
  late Future<List<Especialidade>> _especialidades;
  final Especialidadeservice _especialidadeservice = Especialidadeservice();

  final TextEditingController _nomeController = TextEditingController();

  Especialidade? _especialidadeAtual;

  @override
  void initState() {
    super.initState();
    _atualizarEspecialidade();
  }

  void _atualizarEspecialidade() {
    setState(() {
      _especialidades = _especialidadeservice.buscarEspecialidades();
    });
  }

  void _mostrarFormulario({Especialidade? especialidade}) {
    if (especialidade != null) {
      _especialidadeAtual = especialidade;
      _nomeController.text = especialidade.nome;
    } else {
      _especialidadeAtual = null;
      _nomeController.clear();
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
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_especialidadeAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final nome = _nomeController.text;

    if (_especialidadeAtual == null) {
      final novoEspecialidades = Especialidade(nome: nome);
      await _especialidadeservice.criarEspecialidade(novoEspecialidades);
    }
    else {
      final EspecialidadesAtualizado = Especialidade(
        id: _especialidadeAtual!.id,
        nome: nome,
      );
      await _especialidadeservice.atualizarEspecialidade(EspecialidadesAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarEspecialidade();
  }

  void _deletarEspecialidade(int id) async {
    try {
      await _especialidadeservice.deletarEspecialidade(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Especialidades deletado com sucesso!')));
      _atualizarEspecialidade();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar Especialidades: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Especialidades'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _mostrarFormulario(),
          ),
        ],
      ),
      body: FutureBuilder<List<Especialidade>>(
        future: _especialidades,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final especialidade = snapshot.data![index];
                return ListTile(
                  title: Text(especialidade.nome),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(especialidade: especialidade),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarEspecialidade(especialidade.id!),
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
